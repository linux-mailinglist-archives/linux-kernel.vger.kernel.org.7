Return-Path: <linux-kernel+bounces-753584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06474B184EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B0F5853A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83E2727F5;
	Fri,  1 Aug 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj46VdxM"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B892264BD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062034; cv=none; b=ZjNnfXpyK4Z3+Lm0a0Zr0CF2VQKlHT39lrZnwwWE5FidzVn/2zz/DO9+y8jMPmLdgcbeOoFuz5ORUbGCqZwWAnhhqTiz9UCO/b1APONEzIHOl1BFxkqufUQD7T7R7Ls+FxV5zU6L45wRLpyDZUcfFwL5vT6+x32wcbRfOePZA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062034; c=relaxed/simple;
	bh=zvoXsD6OMioTYdWgIllMIfmYHU7q9NBm9UHBPoGKZQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fueuBryMQYrnhIATItTLiAMnrDy2GQowgjAW+5VAO7tl33oQ5mm3LbUq1zdCISgjzzbg4xKt7iGFTcKVOiW6gFvmf73XTCsFpKOubbb1CBweDHnQcO5mGpfXO8PmYvYb2wuSUzSpaY68HmVfroZqdJr/LpObgm40SIs5cruq5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj46VdxM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31ef3e9f0adso155514a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062032; x=1754666832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sue6t6MTPcNQBk6SuoZyb4NSK8qFHZ5fMm2zaPQjRWg=;
        b=Hj46VdxM18dr7lSfYi62U4z+wpu0zRNWMbhA39idssLra15EovkJG0CUieCtnyf1zO
         P9LkjB8mcqIzXc5qmknjCJi/XJ/NGln8ryly3wDNIIvrFppqCzt6rGLa0hIytFwU8RyO
         tsBUowE1EDYMlXK3Lee6jeQODRBZE/qfwygM0zCGI4IdXRvmmeJXARjqJHTgVTCubRPV
         CsjCLSIeCu7CejMaV4M8/nmLcdKKPoNr3vV7AN3Fe4eyI/r/vXnHqBn7E28mo0QcqK/J
         KW5p0QPcpaeQ1kNIJO1RQJqrU8URhV8tNF/KQc4AKh1dtrXSAfrkoBZnh0IpyT4NKNNY
         Tuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062032; x=1754666832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sue6t6MTPcNQBk6SuoZyb4NSK8qFHZ5fMm2zaPQjRWg=;
        b=qRy1KXelfOKhvd1VyLnmaWrCGnI2V4jhGDIwGWm6klFXS7isoL+jpbwr3I5ER08KXz
         xip9QdN4RDu5fLQIvgutaRjpYZQ1Zo5o/hm+zRsjhXsYI+W+wqDOhHjsWakndNwquBT/
         MceK3jOUFgUHU8/yUHumnn5jNVVmRyexpL/3xouo0vTBSPUASW/Z8NFVH4g5YvNINZtW
         TLdHUyk4rjHCav5bjcJ8g2kKJJgXMA156DRnaR1gHTIXpa1P66L+SlI2XQk+VGrIrizA
         2L81GCLvG2h9KZytVX6aQkrUPet2GFjyFYjUMdGroZ06t2zIkaV0MtR6e8oTu95q/8eE
         qwaw==
X-Forwarded-Encrypted: i=1; AJvYcCWmZxz8QlHwwci+S4MVLXkDTZlDMmmXAKNYJKiiJURUqWi86IEWtZLLICHi7j258Y4ehnID9fxFxwPz7OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaQ6Q+nSHo/w+GHyRRohvBH7jChztTpYYzKPdPtDAU1prf85l
	5fEwVCFaHm9AJkNiwypFm9+EQst57z6zh4RV5m6pV1w473l4Bjj2dn/2Fn2pD2JJKupmM5cRizB
	WhJWb7s7XbtFamgxNSxbYB36mRwhmxlNc5w==
X-Gm-Gg: ASbGncs+R3ZOej1UreaKQgE+UzxjCyy/gYQNZRt93WSnDxFfQl1uYNhkM8RvxC969JX
	6cjLufeQa+D57Bh8+JJ9rLrNZgQx6PIuzCK0ivjf/tXqy7p3Ef5vpr+QIi8yVm1kU417Z7Hu4wB
	npdg4D/DJ41rZ6JubAGNmGNVkawyjC0XFy41509gKfXOYzokPkM7IbdX7pWJR8g72R5S5PxkRmB
	3+cfaWN
X-Google-Smtp-Source: AGHT+IGcY9/E697eI01t68yQeKJXujMHzq8xNHqAlhrRhZMa9gFBozLEmAtafrd865Vr5KQ5G0MMabnPjlidWUIuHpc=
X-Received: by 2002:a17:90b:4b41:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-321161dd619mr105201a91.1.1754062032130; Fri, 01 Aug 2025
 08:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-b4-dont-wake-next-v1-0-e51bdc347fa3@gmail.com>
 <20250731-b4-dont-wake-next-v1-5-e51bdc347fa3@gmail.com> <CADnq5_PG1Am4OGkfKo9o9cfnvSdzwRFeYudbvw220+P1AHO4xA@mail.gmail.com>
 <CA+gwMcc41Hh=or7NLMnG++miHj_dNLZ04iFYdf=U7_LLG1gSZw@mail.gmail.com>
In-Reply-To: <CA+gwMcc41Hh=or7NLMnG++miHj_dNLZ04iFYdf=U7_LLG1gSZw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Aug 2025 11:27:00 -0400
X-Gm-Features: Ac12FXx6aGmZ0f-GSzZPjWGMqlxozfqEFXRIzujilNBKisW76BTEkWFPF_r7fqI
Message-ID: <CADnq5_MpUcifxeBtfk6Q5bd6rjFusRCVvOBOguq0mP6ejG0fuA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] drm/amdgpu: don't wake up the GPU for
 mmGB_ADDR_CONFIG register read
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 2:11=E2=80=AFAM Philipp Zabel <philipp.zabel@gmail.c=
om> wrote:
>
> On Thu, Jul 31, 2025 at 9:38=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
>>
>> On Thu, Jul 31, 2025 at 3:33=E2=80=AFAM Philipp Zabel <philipp.zabel@gma=
il.com> wrote:
>> >
>> > Don't wake the GPU if libdrm queries the mmGB_ADDR_CONFIG register
>> > value during amdgpu_query_gpu_info_init(). Instead, return the already
>> > cached value adev->gfx.config.gb_addr_config.
>> >
>> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2295
>> > Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c
>> > index fe1347a4075c4..ed4d7d72f2065 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > @@ -883,6 +883,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>> >
>> >                 alloc_size =3D info->read_mmr_reg.count * sizeof(*regs=
);
>> >
>> > +               if (info->read_mmr_reg.dword_offset =3D=3D 0x263e &&
>>
>> I think the offset of this register varies across chip families.
>> You'll need some way to determine what the offset is for each family.
>
>
> Thank you. This workaround was specifically intended for the following ca=
ll in libdrm [1]:
>
>         r =3D amdgpu_read_mm_registers(dev, 0x263e, 1, 0xffffffff, 0,
>                                              &dev->info.gb_addr_cfg);
>
> [1] https://gitlab.freedesktop.org/mesa/libdrm/-/blob/9ea8a8e93d542fe61d8=
2716d1a721e8d1d257405/amdgpu/amdgpu_gpu_info.c#L215-216
>
> which also seem to hard-code the dword_offset?
>
> The same is now copied into Mesa [2] as:
>
>    r =3D ac_drm_read_mm_registers(dev, 0x263e, 1, 0xffffffff, 0, &info->g=
b_addr_cfg);
>
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/blob/c64c6a0c31f9cb1339bc7=
00d236932171f7444a3/src/amd/common/ac_linux_drm.c#L722

Nevermind, it's at the same absolute offset on all chips right now.
The relative offsets are just different.

Alex

