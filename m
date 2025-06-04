Return-Path: <linux-kernel+bounces-672842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40468ACD856
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 09:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C5E1895CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 07:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042AF1EEA40;
	Wed,  4 Jun 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="0UX6J2xw"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D42C3246
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021480; cv=none; b=p1oHBxhZCifp6hr4s20GLlwfHebO9q5L67IfCSnYSOXqfOP7FhS2Yhyp/RmOX3QdZVf2JLL7RFfqtDlxscsHCcPeXBsO5TwBoG2/V3CYy5PmKrnSXCQmDuqJRzvgpoMkW9d5D9orNqWTrOSW3ItPtyElMQ2snIuyG0d/dCEjCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021480; c=relaxed/simple;
	bh=AvVQ937BtNde2oB5oSor9GXyudXqQ+VX/ToLMLYiIKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8su2YkjesE7OM6JoUqN4wGAy/25cMx/oBHM6eGwi0NCqV5midavYwmI7wFCpkoOldIyuS5l0t80844W8kJjZbIOuz4cG1iLM2DXom6smZyAvQak41QIarrywlbFmRLDKI9gJlYSEjJWw9VowMvc6F28aLVMedChio6MmMiJaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=0UX6J2xw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a4bb155eb1so47925641cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1749021477; x=1749626277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+nHXGLB1NoYThzl7RUIYtz2LHj026ykSFmZ3xBykhI=;
        b=0UX6J2xwDNmVRLPaSchWR02JOPotgCxHvoWnb32wvJnp4AmXjARmEQBxSWKIAP4/8w
         u7LDd00RrDeE1HWf5WkdoFNlHQ5/Ksk7lDmszRWeUh/mswwWJbqErpyNXosrk0kd6esI
         RbwV6cTGbWYseRa1QQT4K3pf6KBmbq4TJa5tZcqEqYEYVpgckkuIQbuZIg6FGOXPiUMP
         mPhNLgxRcZVgBuLo40+J+aD/enQoHbIA0M1mVUNnhSWE3FiKoEXWiCMZ/XGz5/p8R1Eh
         y3mImKZYKtQ4UbKPtNwOvUvjBQ2yQvJVOysaNNyOIQSkzaNCAfN5bEql1W6TAdXpSRmF
         B8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021477; x=1749626277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+nHXGLB1NoYThzl7RUIYtz2LHj026ykSFmZ3xBykhI=;
        b=U9wwBtH9CI1HXe1itBhXkEDgtKmu5s2OSvIpN43FtHomMvW9P/ksrQThPidrBPLPFZ
         bOH6nOxCL2k+8WWYc+tDG49h6KFSI657o+hJ8s9A13KyOabyTewh5BmBb56sI6PArjCy
         VANUnSbt7v1jLtKV8rrvrF+b65jHGzPlXTQ8YZIVtae0MEZHe/fEDDE7nadrFTv4nL1y
         zBuQDkfPMY3VThWqexi+fMFtlicDZJZoO8lYgOi6r6/VXfKqenPsXgsR9xefHA1U3Wkx
         DBYXKH3HGMLACCcIORGB+MudNWXtTvwtQUSymzqDkveBEzgriu1C1N2rfHQrfFhuj+BM
         SFmw==
X-Forwarded-Encrypted: i=1; AJvYcCXBYZ+7wn8861LQwFvmOXN//3G0/6L+OZ3sq0W1uC8+ilNxmxyfqa3aTcFtjoKBZvBGcgQMSWQECeNbqw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lH/667cOl7FiX2l42zSho1AhNhSrtuxAWpEPt0nty/e30qIS
	o0kYaSeDcxa2PN+7A4Vg+ESSDpC+aw7pPBg/FZLZ1oKm4BJdnpR1l2wf4RDIOawIvmU=
X-Gm-Gg: ASbGncsBkl0L6kZuw1sxTTGxVS3sIFne9uFMImjyDkCuHOlkE7Sc2q4KPhN020jUgkU
	ZQUlZPwBx+SWOSsrTcrhpx9hnCwHupnZnnPi2QfGxnQb74N+lFDtyblNkFQavojvSJfwVUGBOeV
	zNOvcTwRHMposN3wPSMV/sddqP4uunACO8GPnG66qws5fZyBourtiUHySWoHdin2VpSbuBh3lBh
	UyrtA+sGYQoxeyt6sewZGC3X2abySgTx+h6iBc8RfxAUTNu3KkKTwiggR85tJaRebk/WeC13hbI
	gi9U3qbDGVENf4W9dSP35jHfE1Yh7Im+bkYxi+IKV+ayi09gcvMe4ijl0Ryr2k5huFqMrBfk4XP
	FIHkQZnqqzfvtIo7OI8Cf8BMzdoqr2Q==
X-Google-Smtp-Source: AGHT+IG3rICK20WcXmsMqHVXE/1Td3o6kvLBF/u8PF67+sgY/baVQynskCPrTZv+AkTCMa8xnjYnBg==
X-Received: by 2002:a05:622a:5806:b0:4a4:2fad:7cdd with SMTP id d75a77b69052e-4a5a585f07cmr25588721cf.24.1749021477399;
        Wed, 04 Jun 2025 00:17:57 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358d37cdsm90082971cf.40.2025.06.04.00.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:17:57 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so75531791cf.0;
        Wed, 04 Jun 2025 00:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGFEGvWT0X1eZyREBXAHHGk+1RkHPThNGKT2/dbUCeDSJluQC1fp5Exn0N3G8n2mKaZQBLXQi3dgv3@vger.kernel.org, AJvYcCWCkos9rCM/PMUTqs9s95gVLLjJ7fltJNRfdOZvHfyS0pUrU5nQYoazA9yIsKb0qp6bqBxqHu9lziVc@vger.kernel.org, AJvYcCWIPy8rQR7m0WLm3otQ2EjGkSqYXPuQW0WCmUML89Tk9RWHbCU06brEgqcHZBRSIiA/oDiEgLhorPzch/fr@vger.kernel.org, AJvYcCWrOGyzNEZd2JdUev6mUxwGsTnsVeeyhjNVEKdWW+7lUqANkOO4ZmPRSmoIn621/IGp1zcvP9gJdnIVAtM=@vger.kernel.org
X-Received: by 2002:a05:6902:6c12:b0:e81:4200:e227 with SMTP id
 3f1490d57ef6-e8179ef4b9amr1895455276.40.1749021096375; Wed, 04 Jun 2025
 00:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-6-10-rocket-v5-0-18c9ca0fcb3c@tomeuvizoso.net>
 <20250520-6-10-rocket-v5-1-18c9ca0fcb3c@tomeuvizoso.net> <CAL_Jsq+2mvUDWWvtPSryAiCNJP_=1vNRxARxWTS=-O-LTQO3Dg@mail.gmail.com>
 <CAAObsKDE33kZ27XbgeWBqQzrZXDHwHzp2Q6A7y_osC50UG-n7g@mail.gmail.com>
In-Reply-To: <CAAObsKDE33kZ27XbgeWBqQzrZXDHwHzp2Q6A7y_osC50UG-n7g@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 4 Jun 2025 09:11:25 +0200
X-Gmail-Original-Message-ID: <CAAObsKCZiBmy2kBm76V0cWfsLBbHnKzG4CS-bRUBc25k22K20A@mail.gmail.com>
X-Gm-Features: AX0GCFuzVw9QOJbPU8rAaiE__0pakSdSWD2x8uriT207nU1DMDYnxHzJRzNlcz4
Message-ID: <CAAObsKCZiBmy2kBm76V0cWfsLBbHnKzG4CS-bRUBc25k22K20A@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: npu: rockchip,rknn: Add bindings
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 5:34=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso.net=
> wrote:
>
> On Wed, May 28, 2025 at 3:41=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Tue, May 20, 2025 at 5:27=E2=80=AFAM Tomeu Vizoso <tomeu@tomeuvizoso=
.net> wrote:
> > >
> > > Add the bindings for the Neural Processing Unit IP from Rockchip.
> > >
> > > v2:
> > > - Adapt to new node structure (one node per core, each with its own
> > >   IOMMU)
> > > - Several misc. fixes from Sebastian Reichel
> > >
> > > v3:
> > > - Split register block in its constituent subblocks, and only require
> > >   the ones that the kernel would ever use (Nicolas Frattaroli)
> > > - Group supplies (Rob Herring)
> > > - Explain the way in which the top core is special (Rob Herring)
> > >
> > > v4:
> > > - Change required node name to npu@ (Rob Herring and Krzysztof Kozlow=
ski)
> > > - Remove unneeded items: (Krzysztof Kozlowski)
> > > - Fix use of minItems/maxItems (Krzysztof Kozlowski)
> > > - Add reg-names to list of required properties (Krzysztof Kozlowski)
> > > - Fix example (Krzysztof Kozlowski)
> > >
> > > v5:
> > > - Rename file to rockchip,rk3588-rknn-core.yaml (Krzysztof Kozlowski)
> > > - Streamline compatible property (Krzysztof Kozlowski)
> > >
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > ---
> > >  .../bindings/npu/rockchip,rk3588-rknn-core.yaml    | 147 +++++++++++=
++++++++++
> > >  1 file changed, 147 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rk=
nn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-c=
ore.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..9eb426367afcbc03c387d=
43c4b8250cdd1b9ee86
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core=
.yaml
> > > @@ -0,0 +1,147 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/npu/rockchip,rk3588-rknn-core.yam=
l#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Neural Processing Unit IP from Rockchip
> > > +
> > > +maintainers:
> > > +  - Tomeu Vizoso <tomeu@tomeuvizoso.net>
> > > +
> > > +description:
> > > +  Rockchip IP for accelerating inference of neural networks, based o=
n NVIDIA's
> > > +  open source NVDLA IP.
> > > +
> > > +  There is to be a node per each core in the NPU. In Rockchip's desi=
gn there
> > > +  will be one core that is special and needs to be powered on before=
 any of the
> > > +  other cores can be used. This special core is called the top core =
and should
> > > +  have the compatible string that corresponds to top cores.
> >
> > Is this really a distinction in the h/w? If you change which core is
> > the top one in the DT, does it still work?
>
> No, I really need to power on that one before the others can work (the
> first core is also marked as special in a diagram in the TRM).
>
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: '^npu@[a-f0-9]+$'
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - rockchip,rk3588-rknn-core-top
> > > +      - rockchip,rk3588-rknn-core
> > > +
> > > +  reg:
> > > +    maxItems: 3
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: pc
> > > +      - const: cna
> > > +      - const: core
> > > +
> > > +  clocks:
> > > +    minItems: 2
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: aclk
> > > +      - const: hclk
> > > +      - const: npu
> > > +      - const: pclk
> > > +    minItems: 2
> >
> > It is odd that the non-top cores only have bus clocks and no module
> > clock. But based on the clock names, I'm guessing the aclk/hclk are
> > not shared, but the npu and pclk are shared. Since you make the top
> > core probe first, then it will enable the shared clocks and the
> > non-top cores don't have to worry about them. If so, that is wrong as
> > it is letting the software design define the bindings.
>
> Yes, I think it's probably as you say, but I don't know how I could
> check. Maybe Kever, Heiko or Sebastian would have any ideas?

So I talked with Kever and Heiko about this, and the npu and pclk
clocks are indeed shared among cores.

Regards,

Tomeu

