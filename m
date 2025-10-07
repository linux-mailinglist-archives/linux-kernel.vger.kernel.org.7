Return-Path: <linux-kernel+bounces-843692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECEBC002C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB76F3A3790
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882B1662E7;
	Tue,  7 Oct 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiKzcH5B"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478403208
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802721; cv=none; b=cqtJC6cAE46FrA6bjqSo9mglDLt/BulsssWVbWNASqTI/hzq9IGkuQJD3z8OR65Aa74qhku3TgCnv/pK+WTHJcVOYshNym1hNxKQVwZ8dJvt6iwK5Hf+4LdwD4zWNe4543a4Fah5sTljmGpfkk8UHSw3Mponl7PzorfYk56E1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802721; c=relaxed/simple;
	bh=8o9vrTW9v9NxujtzxltQxnMs1VU9+AZmwd3ew3xxaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFNniDCNVb2yBJKK9fqXPBpkFXxhewfDCFCBa9T0auuVbw8c7fXfwAGptxMKl9d2ckLTOqADn4BDqSKPP7p57J9GZ/e7tDE91U+ankO6MgoGs5I2WJHVK6FlXUXtGhWN1t4IsyCRT7eiVbG78n0ulcC/TAZINPo+9DdsJI+TfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiKzcH5B; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-373a56498b9so72768981fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759802718; x=1760407518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o9vrTW9v9NxujtzxltQxnMs1VU9+AZmwd3ew3xxaRg=;
        b=TiKzcH5BY6WlZ3Fszpc9AxxRyy/Hn4l12TDVcV8LwyYuCfylRGpv/7qvEt+yDtuo50
         PimEQ/yRZTov2ya2O/DK5Gx+aAqvfLQhOAV8IGuWzGxKlGWhfRIP3iLJ8MsNsRumGI2d
         tmabJ8nZh55wdYuvQmhQZ07uORjZ9hZSsA5NQCwtHkrriK4SHx+ubjXytPAtgw7uLud9
         m3hmfSQDNxubRz1XmucOj1oAgqgUNZgvrk1lRheHS7BlM5+tNC3CgkEHkIChJvF+G8Jz
         0GeedPbzRpyoSMnJBYmv1HcCYk44l5clkuKqFIpTBoYWB4bvP8NLbIsxRgVPzz4bETzj
         qOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759802718; x=1760407518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o9vrTW9v9NxujtzxltQxnMs1VU9+AZmwd3ew3xxaRg=;
        b=bROrBZBPikaxdi2YJvvRBP+o7pu8IDZPmA06tiTJcFHcg2+GzmyfadUtqP1QbWEtw3
         yHDgw0VE2xNnkfjSKUHEY4DvgsZ66HtdkLd26NsDessaHF8UPGPzMMzkq0Xi5+YwyHPI
         1npDFTNwhABMtliMbz20qnfF3PARylwLIdkb4RFOk/VeboaylbNWHKPyiKxZAAibdOeg
         l/xXL11c+5osRF2NU/6D4JHjb1A9OLCapZiBJdMY4TPRKfI7GuMDIGUIlPC0h33/Od8p
         4S/5Rra0pn7Q8E89RuKtH25MwyCzlauv8rwsqpH+bHwJ1z2A8yD5DawmJhoN6Xjuj0zD
         /Jog==
X-Gm-Message-State: AOJu0YzuPLgyvyKWj+6LdkxCFyFxrnwarDWj3i3zRhrRwV7rjo8aKEbR
	lr6amxXFU5u6tAhxZvtenUl5t8zBES4KJProGH8z8H6drlOnb6t+mD2jlIRwl2KuwvbLdnaurf+
	IjVt8mbngzuTm1ZNr40HYVHQ1VhlocGc=
X-Gm-Gg: ASbGncs3fTtQg80Xt1HUECVSH3yRQRg4twTL0Dm2TMyxEclCqJur126olxfTKF8yPCj
	IHtDWvfxiqkDVk/2WXp4TDJW6bxWsGgSuOVpn3kdIZRFDXqjyx94PqpN1lGjsqCwCdyGQchssmv
	tahYjnWE6ButTHdM3nnnlbQBlPrnPvwGWQa1fj5FZUZVurWdaB/+R543CcCKA93PK5DPH6fR3Ku
	Wm2wqBPcLcklpOlBArFZzY7HODZvYB6ZNm1LTrjrh4pzscZVACkhnY3NwsSFo4=
X-Google-Smtp-Source: AGHT+IF1gnk4Y4uMVNY50OZf45Rr+117fktzQoGSrlyD94XiIlfYhjx42aV5wieA6v4wYVjVZ/DScLoomUccK4fGUIA=
X-Received: by 2002:a05:651c:1108:20b0:372:950f:2b1b with SMTP id
 38308e7fff4ca-375f50e0437mr4210961fa.9.1759802718071; Mon, 06 Oct 2025
 19:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
 <87o6qjaiz7.fsf@osv.gnss.ru> <CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
 <87jz17afpb.fsf@osv.gnss.ru>
In-Reply-To: <87jz17afpb.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Oct 2025 23:05:06 -0300
X-Gm-Features: AS18NWB2IbIkM4cc14Cl6gz984-xkbG_sITIeZ5UPgz5_CmuI4M0-FKBbTtPpds
Message-ID: <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 6:22=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:

> It is built form multiple .dtsi, so I figure I attach the one after
> pre-processing stage. Please let me know if you'd prefer I rather
> manually insert all the custom .dtsi into a single .dts, and send that
> one instead.

This format is hard to follow.

To make things easier for debugging, you could create a minimal board
dts file with only UART and eMMC nodes to reproduce the problem.

It's not clear to me the relationship between the ANATOP regulators
and the eMMC power on your board.

