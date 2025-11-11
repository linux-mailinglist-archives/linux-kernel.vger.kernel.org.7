Return-Path: <linux-kernel+bounces-895455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD41C4DE45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB46434E307
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AE328275;
	Tue, 11 Nov 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH3h+Eku"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7032826A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762865250; cv=none; b=lRgSq1Qg/sxtmPu+xQrrsoISromAdbUjsrJ7hilmBW5oZuqSe2NKGJk6JL50Yker7O9MYCvCC2CUuT11oChpSAOq1JI2Vib+1mNPl/DxN+fVrihZVjNW/wuNlYOSvGUY9Lcm5JBpjBM7Ycs0h9rPumrb98rReN5CbQv33gCoSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762865250; c=relaxed/simple;
	bh=DiyCVpW74AzfmSw2woljowbltxeP4f6oP4DP84zte4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ+KhPrsQATnhVFAcxzEEGRnJ19mSX1gj+cfhWdEHXYjIgZmQxR2LwITP+vbfZyGIF+j905lLo5Em8NF7HtFiUsG4+YL3wMCKm9LvzS94XTOfAO8A7ruhdJZIVPedq91VGsPaVSaWv3CPdYvxS0n+eU/fhPmQj967iR34bVHnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH3h+Eku; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ba599137cf7so3230501a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762865249; x=1763470049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiyCVpW74AzfmSw2woljowbltxeP4f6oP4DP84zte4E=;
        b=SH3h+Eku82lb2q9WHAlGsguYVJ6KllGZv0q31doOOAbEyc5nDVCdDTbBSlTKbJMtsd
         PqWtFVV2vQydbfVZQ0VNjtogs11d0n9if5/LUBsIq5LXZ73nNfcUylN/QrXUbUhref7w
         Ycp/zLmwcd+Ek1lb8ENOKPvj+t/SoHepSCLgfwpDZVhWpYWmr6IPwdXpqOUbW6WGQtFm
         Rqwnz7fF24kN1KYSj5H9cyOW+fhPKVcaYzWaau9jM2lTjfoRl75V0xAd7c3UtlDZ/sBi
         R4WJ02ML0RxdWwy3ZS/rRzSrSXZqqS6Cd/96MivCedyLuM/niikBr2GMiWxGRy0t2tQO
         lCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762865249; x=1763470049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DiyCVpW74AzfmSw2woljowbltxeP4f6oP4DP84zte4E=;
        b=YIXQIsvAwulwhtzE71QbYnD90WhZmaYpkCwjhDMLlx97VU1dQbs4UTPSEbiR0mDNhw
         YYs8m5nLdnBxqzZembbUxOnsqZWEyaIPr2AU1a+I7/GKD36PJQUaJoeWwelrqPewTjuP
         t3y8t8/RFRXZzqSfP8S0l3xEqdxFFJzVQHw3Zxaw9TN0Kp+xZ4+o3BjbPBM+BmX95yyk
         Q4OSOhV5S5j/qNCc0/NU4Qy/BULt45t1zf0+gnd2p6EHhgtxR260j/Fa8guDF9x52mIB
         hDYwfL1mvVDh++o4OSn3zUwyo9sRbaM8NizNI26Pt0G1/sYSfYzBQqnCrSl/x7RbyWem
         3GyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Cgbt8SHm/gCodoWEEjbIVvr9j6oE+3lsI4nCBWJdoW753AC18sACzxz0bzGISa9C5gMSdAQFnnl+15Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdttxKaI8JzTVurdIUXpRSxj8PG6aTEWt/rCB4nDeXi0jXSTHk
	Zz5Y7DwVGxRuDgB2iXuIky84hH2y1Ob74l3HDZ+rDmCX05+EaewSi3EtTM24CbxQnSFsx0PNFnT
	yS/X9Gma7ArA1IqCGTBd2mXIffIyTdvE=
X-Gm-Gg: ASbGncuIp5kMuOlUZDMV11CgdUTk2I98u1Do0d1qxsM1XOncoEwyaf432D7fN2arSVv
	XUvjHprXGosJQcCVkVxNefCcdN7jp92SPOQTzHpArSTJqCeflCzJYQTWb1aGnlb3w+g4sb0BZcC
	7MoA6Rt77cwQZwLkblq7H2FHDsQBcXrX3/NyiBu4HTiKrIcV/M9ycu55j0I04Aj/s4ct8+/q8IL
	VXZGNRm1AKL1CunZX14NfVpO/jC3QgNF74GzHOV8aSJezQRBpfdWWWnqA==
X-Google-Smtp-Source: AGHT+IFJOONKkMfXdqPbe11hbjBNE3dvsWFF9H5OLiJ4S3DIHKfijXdDtwbm5zbR413VDlyjBE1eFW45EeSLVlnkRWU=
X-Received: by 2002:a17:903:2b04:b0:298:43f4:cc51 with SMTP id
 d9443c01a7336-29843f4d1afmr23812835ad.60.1762865248764; Tue, 11 Nov 2025
 04:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
 <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com> <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com>
In-Reply-To: <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 11 Nov 2025 14:49:49 +0200
X-Gm-Features: AWmQ_bkTj9C0dCRYaaW6vS8S4HAZCMkKvqfHh7nxztfpxPDtGEV8r1QKd9FonHg
Message-ID: <CAEnQRZCHKemw2YVT=WVJvUMr9CCWoZ3MORt_mU1V-62C53n-3w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com, 
	marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de, 
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:50=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Daniel,
>
> On Tue, Nov 11, 2025 at 5:45=E2=80=AFAM Daniel Baluta <daniel.baluta@gmai=
l.com> wrote:
>
> > In addition to that, Rogerio please read:
> >
> > https://docs.kernel.org/process/submitting-patches.html
> >
> > At this moment I think you should keep the original author of the
> > patch.
>
> Right, but NXP makes a total mess with authorship.

I cannot disagree with you on this, let me clarify it internally with
NXP colleagues
and sort everything out.

My guess is that when the code was released via the meta-imx-frdm Yocto lay=
er
the original authorship was lost.

Anyhow, what is important for me personally is to have upstream quality cod=
e.
Also, in all fairness we should grant authorship to NXP people and follow

https://docs.kernel.org/process/submitting-patches.html

Thanks a lot for all your help and effort!

Daniel.

