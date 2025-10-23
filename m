Return-Path: <linux-kernel+bounces-866530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C13C00063
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B51119A753D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5A303A17;
	Thu, 23 Oct 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT3Tm9vh"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7823019D1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209512; cv=none; b=NPxS1eCAH8q+3Zs3ruNqZMjTFuRSdn7FqOheBMvicrTktYaRjv0LSVRyhX9sYhItcpyciH4Na1kTe8ipj8sTmx8DUF1M/5WAuwOyfjlFtROXSEaBUUM/iSnM6jm44aFrYEj5GTK0tEV34vxTqTdCMG7d4yR6ih/VKmwbpghA5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209512; c=relaxed/simple;
	bh=Lia0EGpI9PV6Wa7Mt+zwkxVNwILAbw34cO4vX/DEgGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWKARch0uiz2b6Pp6nK6WwjKOCfp+ITJQ3qi9JpqERjhh2jDt/inhRrQu6L2js3tsbmUi/uNggrXQB6c3J4TwotC5yvJ2TSVxqQo/D3h5c+8vZzoLAjTCyH+6Rs1HUNIkndexzoj8Vt9XaQQJf2+hODeHrNDRROZUcsVbA716MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT3Tm9vh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290a3a4c7ecso6391745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761209510; x=1761814310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lia0EGpI9PV6Wa7Mt+zwkxVNwILAbw34cO4vX/DEgGU=;
        b=bT3Tm9vh5bJlWhjWrwRefGdFeG2Sk8sa0FpMd3AcRbUJ5ohYNtYWaz+rx4DUprkZeL
         OmN3B+S3ALQ/0QYjTUS5GF2aEe8kBm5ThYgCaoUp8fCsw23Ci86FcWwG0TZi8T2BsTRt
         89708rDLOBvt256sq8GIn4J8UJXby1AFGIEHv8yJd2NgcW0Y1j2JTNUq67wcDu/MOGkc
         zGzXJ0gn6JRTnwe/QJ/oquoR0Crkrp8acI3hILkU7Q5+KxkxtX+sPOa/O806leyC1ems
         VkZerpuadZcRUVRby5rJ+UCWv3abj9NGo+dkQIv8QzjqS0hx/+dU2XE3+go13OYiSEHP
         ohIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209510; x=1761814310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lia0EGpI9PV6Wa7Mt+zwkxVNwILAbw34cO4vX/DEgGU=;
        b=oQrpR8dujUVxB9wzW1N20X8Nubtm7gVpvfjWQaCBGhzeekXtvHytPOvaBF9rv0wTA7
         hXrr1ty/kgKrnBv+7dUDjYfj09Ii6FOWsgIGusLixsSHsRPPYCiguCYZKayux9Gp5+2k
         TqlpvV1S/q9BsCFbmUbIKjsXWvTY1KUXPEcWGSnBqD9AvT/V+NpXw6p0/ccnojK0nDKf
         3Hes7ta5m75yUMCYPI47zqugMPTlEi9Wso/9Ep7opt4LxrsD1zymoBr/F4eMxsGaWOtT
         wvQw/PTjujS1/lptNrPMkWY45hEw+JYOh381BiNPTPe5Kc8nbQN86/Jo1KUFoBOfDrlV
         w0iA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCwQNGBz5iRWaZhwttPP8mQaDAIiYl6Pj0dfO3KC8FtWStdbLT/dFEksnlRjNez6Gjd0p7fD0vfrz86c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Gs+utczdDXtQNoTkqYwtrt+DXxJFqqL/gJ43mY+4RhnJL+ui
	EZVk+u3+rQ2Cg/aF291XzS3okFZ/eNCwuf4Nz/7IvdpxA7tuUjz/ov+pmdXJ7yTCnGqQ9qs6IdN
	Nj4usmKbNyInsIa5BpSZolVfk55/1p9w=
X-Gm-Gg: ASbGncsPq2bnELbVKEUHpkS1MssC5El9jhYOTr1vCUgO21wQUxfpoYqG1hjpSzlJpWV
	2UMxgUeJmCv7du8o1y6RL0Hi97UXMiouJTImZ/LRXL5FjcVOad580YVltb5+lKGCRPfrwtjXqtF
	f5RM2KQGx744ESlq+V8k5bZeN6CcOym7RzP/RyiHuEzi8YjKUVv3Ia1ve9IpD2TW/Vl7LeXUnHf
	EOTNCOKRTEQW/YOiE//mn/j1KoZ3s8qEBAy51RgFJTbmQxVCuNrq8EpRjj8QVR02wTQY+/ShHsj
	YKVrIzsppuGGiQ==
X-Google-Smtp-Source: AGHT+IGVhcbDEMKuw//0lICyRubANBw5BQL/FcN59AYvKRLUM4Q47l9Dc82sfAc3l7GBs+Aq9SlV2iNwhGdQYMKgAJA=
X-Received: by 2002:a17:903:2b0c:b0:27e:f06b:ae31 with SMTP id
 d9443c01a7336-290cba52787mr296045245ad.61.1761209509923; Thu, 23 Oct 2025
 01:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023064538.368850-1-shengjiu.wang@nxp.com>
 <20251023064538.368850-3-shengjiu.wang@nxp.com> <CAEnQRZB+rFudpHB7TKFOCumh4Ni9q-421X3jRL2y8UbV74e-xQ@mail.gmail.com>
 <CAA+D8AP4t+vS_n=VvRR5YYYrp0DGdWvqSN+4U0ZWMaGHmmt9ug@mail.gmail.com>
In-Reply-To: <CAA+D8AP4t+vS_n=VvRR5YYYrp0DGdWvqSN+4U0ZWMaGHmmt9ug@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 23 Oct 2025 11:54:08 +0300
X-Gm-Features: AS18NWBXVYcg4iSh2cxYMtB5rD3rArP78fbSE0SD0ku2-r_FGbA2hH__QJQSJT8
Message-ID: <CAEnQRZBiUu+45Kwe8dy=NsVULj3j=+zmgUEtg1SjZyP8KBpjTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_micfil: correct the endian format for DSD
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:52=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail=
.com> wrote:
>
> On Thu, Oct 23, 2025 at 3:10=E2=80=AFPM Daniel Baluta <daniel.baluta@gmai=
l.com> wrote:
> >
> > oldest - > most significant bit.
>
> 'oldest' is from the time perspective, which is aligned with the descript=
ion in
> https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm.c#L2050

Make sense. Thanks Shengjiu for the explanation.

Then this is fine:
> > Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

