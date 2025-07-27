Return-Path: <linux-kernel+bounces-747031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43521B12EE2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFF218982B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF0204F99;
	Sun, 27 Jul 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM1NHfHU"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289C1FBC8C;
	Sun, 27 Jul 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753609877; cv=none; b=o/oTn63mabdfSF7JlfsWnG9amLuhxzpgt9U1PjhYPsDP+kxLcgN1Dyr+4YSxKqSj0G8vj13/FSBwc7C7XnKIbDSTt6sY3CuWsN2zXNbGKJ9XtZCyiljqtLjquf0rsl32cesZh0Q5O2WzNnLiueanpSK9H9qdv0ezaWzW8j/8GFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753609877; c=relaxed/simple;
	bh=hw3lK2Gtil8LoYjc67bdQYFl55Gch/gUtLQ2ogjs37I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMVcVPamdLL6sGZIzerG/fewzbCv1b+oaH/zE9byjZt4ysPORDmR8DkCzR9HW7wiK60EmkzEm/A0HCr03TzsxXeA8EYFfeUoO38nA/WItzongGcTh+YBRXp2m+2kyBz+LgkU78KPBPJAAmNtLxbrVxPk+aS8xiJSY6zN/g12eGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM1NHfHU; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-615df2e8c27so2031132eaf.2;
        Sun, 27 Jul 2025 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753609874; x=1754214674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFeZkLi3dXMjYKmhsyulgqSrNnECKk/svpVxCMAGOH4=;
        b=KM1NHfHUrUEuAdVvCMLaDesPHoqLCJGjCuyMcl17rpGEUxWadj1Le5GbRf93Yxa+Sh
         U4EI9PZXBhHgepIQhwl7i8550lgEC2joqgaqDCeeC2bSk7qR6/2Dwe6A6kbogfSf6Wwp
         G7jZfuRKkLi7TnkdtejqJeNfxUasY+z3t4lifSIctDFa22SozDr5me6H2Un4QI6dOiaW
         4Dp2fWXKLR/3US4FxjhOSmpUsRtCnv5U+HqLEA41o91QB+XC+0hTCKD6/m1ZkENtm2As
         mZcpsh+6xeN/fd/zPu9vPJ2FzVJR8miflzzpgt+Qj/zfb6ejs4WrwjIdP+5OFAhbbk3s
         +FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753609874; x=1754214674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFeZkLi3dXMjYKmhsyulgqSrNnECKk/svpVxCMAGOH4=;
        b=rbs1zSBk1Io7nGuQlfmS++OHwJ8hjbhxY3ITTbWcZBwJ702t+bjqcHoMsrrjpaVm2G
         hu77Mm4XnhbTqMzSfcm5mY3kGTTAqZYZ+Hkn7x71lL2NGJiSi8n1sADCLwlIi7k3C2ha
         FFWUoCxMNdLtwifTPq/hL5jnzkjG81wB9y3HBucJ1h0F6lM//E7qSnQxXU7Iz1HiqDHn
         XfFr9KaNKZoT4Cr3oCx5vV1DPSySaw22Pf6AkcMEwskirO8enBOymCoVhjAej0/Ldzyd
         sf/gp21EE2ajhXQ25a1hiTUN4UByh1R4XUkeSWP+Tzhb6PevNWsmz/41nrZ49o9A2FcZ
         uwcA==
X-Forwarded-Encrypted: i=1; AJvYcCUWZ/ReRj52olguVCvtFVfTVie7fmqUZX335GPJhsv36u8pY7omL6ouIqxHLEXkZlrpWCgnEBNxbsg3rsQ=@vger.kernel.org, AJvYcCV8dLgjS+5QWGDEL5I7/DZk0je6W9ktyRpvqcCwzscQEcq0jZgIxo1ObIvSQDSy5db4rhPU+RBqcOtQd9WPDIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAogJcYOdfvgAvMTOMiXG5btiuHOMlIIJmfzqw3QScVXe72b2
	LZhZVCFLdA84nZmi7kMDN1DK3/Iu0RSGNc2aJw6HhlIo+XPu/wBwd2IaFwS0FRIbtPMFEhhp4pC
	Y79VqiGo6Zg8A1MTqsMK300+/veJccqA=
X-Gm-Gg: ASbGncv8d6SBQmQTDM+tdN+cSf0csjEfWKYvB3LblyVpVR9K3B2Hf0UmNIvQ1I3kovQ
	G7MoaT/wVxAAaHEWdfkOuKJxFFL0h8XwNyLpnRkX2WwPrnXd/D1MQj59Ck8ZPJ+jInqIcvMO/tE
	QWPRwEPV0czfxXTh37bjKOZ9McdmaVZApTsza/fCamCsMuVeglSOHjgQziiKBrF/yg1ZDXZbmbx
	cx6t/wYuPbXkvUFJP0M+3N47cvI4jVAMysi6K1W
X-Google-Smtp-Source: AGHT+IFrYgebhq8gmtJdDuLT1R1NJegqag8vHwHBlQ7UiW0xS1gBt/xj3wz+uraz0qf/jzt5q2P6fPA8Y+A+zhmLNyg=
X-Received: by 2002:a4a:ee0f:0:b0:609:dd17:795 with SMTP id
 006d021491bc7-6190c9b2767mr4863242eaf.6.1753609874595; Sun, 27 Jul 2025
 02:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718073633.194032-1-krakow20@gmail.com> <DBL6BUAHZ250.3UCFP2OB3UEIY@nvidia.com>
 <ab63103c-3b21-451e-b450-a1755b452d77@kernel.org>
In-Reply-To: <ab63103c-3b21-451e-b450-a1755b452d77@kernel.org>
From: Rhys Lloyd <krakow20@gmail.com>
Date: Sun, 27 Jul 2025 02:51:03 -0700
X-Gm-Features: Ac12FXz6IRrbu5D8lGdf-x7j5aaSoITICjmtxz8OWjJATTXn2XMK8AX82FcIyc8
Message-ID: <CAH7AjUzfc3+SFNKWDerOY62M3OU8=wX8Qs=Bj_S-uKo6w0nuYQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: nova-core: vbios: use offset_of in PmuLookupTableHeader::new
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, rust-for-linux@vger.kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:04=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 7/25/25 3:35 PM, Alexandre Courbot wrote:
> > This chunk does not apply - on nova-next PmuLookupTableHeader does not
> > seem to exist. I think I remember you split PmuLookupTableHeader in
> > another patch, so can you send all the relevant patches as a series tha=
t
> > applies cleanly on top of nova-next?
>
> If otherwise the series is ready, please wait for -rc1 to be out, and reb=
ase on
> -rc1.
>
> Thanks,
> Danilo

Strange that it does not apply.  I'll figure out how to send a patch
series and resend it without any changes.

