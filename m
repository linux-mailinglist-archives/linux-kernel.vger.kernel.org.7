Return-Path: <linux-kernel+bounces-813380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4FB5445B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D119F1BC2B05
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED32D062F;
	Fri, 12 Sep 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52kwwWy"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F02E401
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664044; cv=none; b=h1wlLsqwgmgnYYTs0ugPeAwgpAkDigqTvtSjc9zutEul2Ad3RYMz46n7AtgdHqxIL3K3tWp6onDoYh4TeTUOtI+TjdpcYeR1qDi8dexXMuqxxTuEfLIiOy15oqcs+C7Tcj/cVJvIx1unv9Dy6bU/C3L6aOI2HNB0kLLLO3etUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664044; c=relaxed/simple;
	bh=RddhR7Ytc3OyDzAj8qMdOCAnXLaH/yrMZCo6suiwK8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvKjZGOvU7z31OqdCYSgElw6J2uiuTI0s6/sM1PXrkKV+MAcds57pPAWu1Ud1U6lVFFeSjyIQCtoNaLRoapfkysZSzIroCiWCT39IdM0iCi3umGfWAcn+TDeIsxDFsssdqiIIRX4g6DU5srXDuxBB8b7aQEQ1AgORU4KnBcfbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52kwwWy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32bae4bcd63so1139391a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757664042; x=1758268842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RddhR7Ytc3OyDzAj8qMdOCAnXLaH/yrMZCo6suiwK8U=;
        b=B52kwwWy9nsE2Y/iRhPBOdJgTfAsta8pQikxot4a65/Z1Lo9yqvwBgZT8u+A4J2rKj
         QQSJzbcRgWFDRAXp9Is8VT9DhjXr6N/aOWdWlBD0ZyuF2bbOdxBK8LEL+QZC5rSL8ZtB
         8e1o9ZkKNerZlqHVOP92+HeTpXe0X4W3pQ2yOrSwAuIG4RX8gbV5qYc9nQ6vQqLXisGU
         Q6HkyzblPn6eqWAfJ9w9oTrJBpu6dfGbAttY7iOxrlbPY5jgXGrkQlGtXCxRxOcEj+Og
         UjC4wszebJuTvEV7jkpZCfBrwtR9iVU7MWmjMZzQD02DfY7qvVakIcssAW1g0XDb96wv
         BHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664042; x=1758268842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RddhR7Ytc3OyDzAj8qMdOCAnXLaH/yrMZCo6suiwK8U=;
        b=mB7ewLrsGNue215c7HbadrpDIwR6wLzW0XhTtvX/7jBx1xoY47PofNHg0u9U7Ecoch
         /D9PVo2U/d+3OmaD6BawNoYRO/Wjp0KYxcGSmwE5lzXW6r6eK3eHnEskWu+7odqIo2ac
         UBEl6Z4wbcwg/WqDeZxkjdLyMzWo8kBqocKbLF/cPfeoON8gIJAXZ+C+PgPJF2tpgc/L
         9oLHeM9iGwTwVBckxJ31LGuTc+qkRt3+LUW8c4hyDJDxql0DCbOPp6A+vw3UBJndoeMN
         tQZz+Ro+1FMYv3oYaBrd2C7EJMzIrIQCRRJoZUgqVnCQ4XgWrnxMZid+2G2UciFfiLLu
         duHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5RV4jg9DCBEBxwiIE+NCstwy0gbKuBAq5Y2r4J7xUjkDe/2vbNkq5cDXBOiC843PN17lu/D+4q16MF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVVLep8hnXfCBkIh0zEbnQZ6LvDHYldOzIueGmBvxJMu9OoRG
	bWuZ8m+qiBNCxf7+ffSlmHt0spnkHLyiNogJJOVYVDZsn3dJivl82zo9VP1MszhNJW34t3tvEFD
	XWAh0eoYUsAgr6OZLCTcghcskLx4FAt8=
X-Gm-Gg: ASbGncusxutJqbE6vs2eNiw7GL6JKj3xHwjoNrCNSrm9ru+MjzKnBaMBh8WEWga16xi
	Gl/9LLeT2T0LSi/8QQZJEieVseVSWmB6vDAVPoj5GlRmZo3cUKGhqB5AzZgfpmzmGM7L39gcjok
	q2jtS0OcyZdNYTaaMTV0BGOZGuiMdlg+b/MlbF/hFXjVFHv1ZPdQLVg6lOQ0OdWn7pwCfIBMWf+
	z442Cev5vJ1ZqSQ46T52eF0U1VDw/GhY1Y6hp1lk0loo10u9VHY6N+gDZzjwe1VLul4oeWD9vu2
	O26eGJLJ/wTteoNGRpiWglguo4g=
X-Google-Smtp-Source: AGHT+IHTYqhOqiiMZhoB7qwazwG+9e9lRsDH3mh81eXodRoVjUVVYKsEHquECCI/o050/JZStBy0AmsiSCwPErfROkM=
X-Received: by 2002:a17:90b:5910:b0:327:b33e:39d5 with SMTP id
 98e67ed59e1d1-32de4fc6aecmr2836744a91.37.1757664042269; Fri, 12 Sep 2025
 01:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812051949.983040-1-linchengming884@gmail.com>
 <152133202.103367.1754981828821.JavaMail.zimbra@nod.at> <CAAyq3SaEqYiKhbjYwLH0p6F2G=UR-MwZF28AG1xVMoKhznS3Og@mail.gmail.com>
 <608935583.115196.1755171013804.JavaMail.zimbra@nod.at> <CAAyq3SZT67uwggdNX99qEc4bwSkUw2U=sCc6mon064D=f7oH=w@mail.gmail.com>
 <1899901955.27456.1757663848457.JavaMail.zimbra@nod.at>
In-Reply-To: <1899901955.27456.1757663848457.JavaMail.zimbra@nod.at>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 12 Sep 2025 15:57:36 +0800
X-Gm-Features: Ac12FXxHIG9JDgbXSdKUNG2K6tSLVBXwdA-VsSOyFDqVojZEJmLsJB2vCnz-G4c
Message-ID: <CAAyq3SZmuTPrEb4i7QR-4Gi6YWsLFGOGm9=a0UvLR5rMLiLxsA@mail.gmail.com>
Subject: Re: [RFC] mtd: ubi: skip programming unused bits in ubi headers
To: Richard Weinberger <richard@nod.at>
Cc: chengzhihao1 <chengzhihao1@huawei.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alvin Zhou <alvinzhou@mxic.com.tw>, 
	leoyu <leoyu@mxic.com.tw>, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Richard Weinberger <richard@nod.at> =E6=96=BC 2025=E5=B9=B49=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Cheng Ming Lin" <linchengming884@gmail.com>
> >> That's the crucial question. Is this true for all NAND chips?
> >> Do avoid larger writes of 0xFF patterns file systems such as UBIFS
> >> also use compression a lot.
> >> At least that's what I have been told when I asked 10+ years ago
> >> how UBI works.
> >
> > You are correct that there is an issue when blank data pages are repeat=
edly
> > erased. This can lead to cells entering a too deep VT state, which may
> > cause program failures in subsequent operations.
> >
> > To address this, newer NAND generations typically perform a pre-program
> > step before executing the actual erase. This keeps the VT distribution =
from
> > going too deep, thereby avoiding the blank-page degradation problem.
> > Such pre-PGM techniques have been widely adopted for roughly the past
> > 10=E2=80=9315 years.
> >
> > Additionally, JESD22-A117E (page 6, section 4.1.2.1) specifies examples=
 of
> > acceptable data patterns, including solid-programmed, checkerboard/inve=
rse-
> > checkerboard, and checkerboard-with-fill patterns. According to
> > qualification knowledge bases, using 0x00 can sometimes trigger special
> > failure modes, whereas writing 0xFF is more robust.
> >
> > Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
> > that continuous program/erase cycling with a high percentage of =E2=80=
=980'
> > bits in the data pattern can accelerate block endurance degradation.
> > This further supports avoiding large 0x00 patterns.
>
> Thanks for the detailed answer!
> So, yes let's apply this change.

Sorry, I need to adjust the code a bit, since I just noticed my
condition on vid_hdr shift was incorrect. I will send a v2 version.

>
> Thanks,
> //richard

Thanks,
Cheng Ming Lin

