Return-Path: <linux-kernel+bounces-886827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E50C368E5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040521A41656
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C993203AA;
	Wed,  5 Nov 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxw1LtPs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A322258C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358140; cv=none; b=LePQAv+7I0L/vrbepL2fqNuzLjx3PHTtxshu3lnRzTEn9jBnw0DSG7ejpc2pK9vAlHi/ka8AIwVxSwia3JbpZl3jL4cCt05gIjENAy54J/SdqWRBPbx0W2DWW/95HdtWVFJ9EnRJ70nzb4OUalJFS0fM6MLZWiQYz9/pme4vblA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358140; c=relaxed/simple;
	bh=Io1VyLd1gRAuF4noSMJeCvamZeFl5b2WHdevUDZuHy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urjEJ5PWtjyqfKkBT708qP5HgbeAUXWQj6cZavnQorO4WUfy0xJk3t+uNDHJNcdfa/qxIjTvGfQdrj+4mvqYJmrJh0XbCunpZcmzySrqTNM8TOT1H0BJqeBF8ZLWbub2u+PA6ER0svOs10MbdlJQP4JlhnJBp7f9saqSO7UdG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxw1LtPs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594259bc5f1so3188115e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358137; x=1762962937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io1VyLd1gRAuF4noSMJeCvamZeFl5b2WHdevUDZuHy0=;
        b=Zxw1LtPsMpzOhdk9lrETJIHdaZWGVdK6jFv4ltJuoNHJuYa88DqL0iDz2g06ouRaz6
         KYIV4YNVRrHhT1wNqSU2ie8of67ZmMvnS6Qi10B/Qh3xIBTACGBfUCDuDLAehGviHtyI
         ziBGFBLs3WRsvrN8Q4W/dgJTY3wRDDV4dWudqOuJFd0P3cqk5gf3JG/biO0ejav6Dn03
         S5Kte/Du0CI9I46smJUZcD7Bg76yUa3V6SIG3iTvCE7QkY3lQM6kiQ21XClf/cXadFhJ
         2dXZ/T7Z3WAIp7WKkkfyCfW8XX7TnU+bD6sQib1S1J9qg9JskJxBPPon4JXxGf+z+Le7
         RnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358137; x=1762962937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Io1VyLd1gRAuF4noSMJeCvamZeFl5b2WHdevUDZuHy0=;
        b=p3MrQowkrV+32L7pQ0W4HqHcBXEy2I3JdVNv8MzWeeWAUXxfVBipMd6qo7Lr+3gazL
         SeYcwkqAvYRtgH9JL1BlxV0kURuQzX6HbLF6Li8FY1Dln/S/sFGFdIkuLEE7/uKVdarc
         CRam70E4ucGoquk6Kz2fFRzNxirT1BV3YEyiky+W3I6Qllfuv+qcRTT7BRGbbqFwIxWT
         IhpMWdcX9VimUHc8KNf2g/PBqOviPbTOGQNAbueGX2LorrDcAVxwYkHLcakIHbPMRdPq
         Kbwm6vJd8SZ8hpy5pX2EHk7E4XZo4BzC9w4G/YgNqkROAwFj2BeKy1Ew2SxCjxFv2qo2
         O1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWMl9C9+bxJmyT65B1wGLNhvQfqdFpmyWz9569eQOmC5mHQrz5ZUlO3jAKM1hUZcqwuug/wIkvp2BZEuCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9MhJWOFVL8rpr+x16NHdSUgH66Uoq6WLv3RNJ2DEkoOmbCxr
	Dx9QrlNqY9/LMM1ARmCTb+YjD9AzZhwy3lBMMqwvy8Owo3sYJ4mOU8KBhaiPX/gli0HexhUEUP5
	ltsQq1WjrCJRaP+A9Hho95qUTd9dk5QA=
X-Gm-Gg: ASbGncuvzshGQ8uZmWbzVvoOWAFadh7OKbWZKtcUKLQIQJCogC78xPmDSpmAq9YPVA7
	GYaI862Rh5UGx2bHF+jyxG/RzyN5eUckRiwbYasACVRvoubMPOYld5FV4cBxrcP3znq+CvRTjlr
	k7nUhZvFLmh7nIqgbJlnNpT5+EXHnNqajcbnKS3qoWnCBzUY6ng1dh49XXo3ejsInzHB6CpiL6n
	0gr3+n0x0a06AocFHcWEyJyaS0yuaWYBqSNhnQnYYSa72bmB8PYNQM7JTVP9BQVIAlyrl6p2t8a
	qFg96UQXjdqQuxCp
X-Google-Smtp-Source: AGHT+IEKZD2r+A6glfOrMrg4LC6QbMe/1oJABd/0/CzvD1LhjWBFWqHF/ZzZ6hEZaZ4L0CrW3eHh11z1a5+Hf0RYLbg=
X-Received: by 2002:a05:6512:1390:b0:592:fc68:5b9d with SMTP id
 2adb3069b0e04-5943d55dbe3mr1269961e87.10.1762358136484; Wed, 05 Nov 2025
 07:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105152555.1992513-1-michal.vokac@ysoft.com> <20251105152555.1992513-2-michal.vokac@ysoft.com>
In-Reply-To: <20251105152555.1992513-2-michal.vokac@ysoft.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 5 Nov 2025 12:55:25 -0300
X-Gm-Features: AWmQ_bkzywn6dkKu5hKn_kdsHkqaeTB3gPh3L9WBztucxEsOta2CD1J3nctobCE
Message-ID: <CAOMZO5AKmKWciyF7-f_mVfJWdLB1rjh_Xi=BhkBAcmV=cJ-nyg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Model the RGB LED as a single
 multi-led part
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:26=E2=80=AFPM Michal Vok=C3=A1=C4=8D <michal.voka=
c@ysoft.com> wrote:
>
> Describe the RGB LED indicator according to the reality - it is a single
> part containing all the three R,G and B LEDs in one package.
> With this description the chan-name property becomes useless, remove it.
>
> issue: HWOS-816

This issue notation appears to be an internal matter. Please remove it.

