Return-Path: <linux-kernel+bounces-828696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A9B9538B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313522E3694
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF431D38F;
	Tue, 23 Sep 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4u4AjKV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091B285041
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619279; cv=none; b=fAZogrVUbcHCUod+y3GMun/mu4gOqgVRxQecN3AICYTeo3MYLmOMNBVUZu55httAMuLNeD3u8Rj6PYG69v6yt6TvJAg59FqoJvYWYUO749jkupWhsyikDAwxosZulHNfSIp7FnJbU3S3GFJjajxAFPwREhiUliXuAQcSuNBfBow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619279; c=relaxed/simple;
	bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIKc7k9DhanLZJoPiKVMHHHpH3B3MGFYlN8wWHoGBJiMe1mxvGRwe+hsMHoHEn+klzzrHyxdpyi+6PHAdLdOb6b7TfOy6H8Tly9AhDFesP0raGVMUz7F1S6aLEZHoAAxpjtKuA530S4rHiMryGj9++bLPerZp7ZP1JA4r5j+BuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4u4AjKV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267facf9b58so39133155ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619276; x=1759224076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=h4u4AjKVfmAEskwkOvwzqAgL88xwomHfGrvqa/5xhZTFEvKPRDxQ3mzuuNdgvUhCoK
         kf8eytRgKJqhaVcHEnd14tfDLk4r7F0OulEsicASVZuyYg0kGQVOdiS3RVqTmXs+RKfF
         5CMt5HxvdXkogUdqNdiB6nrFAVo7BZlFfk5fDdN7/YUVJGhWfK2vX2Czbky8A8EHk9Wz
         xmheSDvK9GN7pax/RoyTCabh7iBQUZAZHIhVaSIRi7HFJOdLpxbjv/FrtG/4C3KHWm3T
         6nxbMtXQ462veq5po0xK5zqGjkv5OfgiVKrhGSWLHCy56WGWB2HWeV5rrvxhxsKaxH7a
         vkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619276; x=1759224076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cswo0LzDGBX49wI8j9kkVMGd7/Ano3IZZWfL4sip6E0=;
        b=Vnv4TFpWRggF4YcfnPwitX0q6ZcLRR8RewzB8lZUrcSV5SxIp45dc9oHCz1G/hatr2
         Z7Cu0B9MxvcnkgiHKMat/U91ijcMtZiKMM59ETC7qekalswhPZUrnvIL6f56HQcGQ3rb
         jDanJDGy89xmpN/xaExSLB2y9HL0595HpURgHRLzVVZdhi23PGhR1vkB+oB+LXdfCZXk
         p+9rwsWcyVCpmrm+/hHjYnyKIMeYa3MzHeo23m+5BVF/bTzZCuNrGOVqJAZxQUWEETl3
         xkrR4/B+FaiRQijOMP1rexO6zu41eigHdIsuadcBoN6EbQ5ScE6SNne11K4toQamkEZY
         WgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPe/xKpBYHjooWna06MmD9pSDqkJhaGRvbggO+bjrycaPpa6cSKkx5WxZpLvJwEpLlUU/oSgnbz1T0XRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgfBughZW9YbqlUukr4ByWnIr+31eMfhb94UNEHmNZCCiaFuT
	I4jb7uKFIv7E7hVHD9ogoK86GdylZmql3dvFqCtrDXcEtD4bJfs181r1rQmITtTwxBuq7WP46Me
	DtDMaU4l0I+fq3RyJNVPlB7R6yovVh4o=
X-Gm-Gg: ASbGncsndTsL9NRzQ4rTHIRPQkNRmAAil+fpyJ3JyCLsEypsLFmnSw03WbC5O0ljQbI
	qRZpDCdghGsA2pUjANLlo8/nOPUO171Aq+7VKZXE5irJV21jukSx16i4oX77q3HBN6AhfbbKDA8
	Gw6L86JkQTDiT5BVEv4PtzCzHLvVpvIWj5QTaqE5yRFX/K6Mf/G8ySsH3ye7QlxmzxifYhWVCtD
	+Y5p9c=
X-Google-Smtp-Source: AGHT+IEXMKhCjwTKhodebRPoXK/OAjJWAlGGH8OjPPnekcnhylOt4yiZehwUT2NqIW2Pj2CyhcJ/iwqTogEC2ndcvmA=
X-Received: by 2002:a17:902:e790:b0:269:a4c5:f442 with SMTP id
 d9443c01a7336-27cc712289emr25047665ad.47.1758619276576; Tue, 23 Sep 2025
 02:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827013539.903682-1-terry.bowman@amd.com> <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
In-Reply-To: <aNIUAy6VbNdSzplJ@gourry-fedora-PF4VCD3F>
From: Srinivasulu Thanneeru <dev.srinivasulu@gmail.com>
Date: Tue, 23 Sep 2025 14:51:04 +0530
X-Gm-Features: AS18NWBwICuC4DXdolnXhBDgNb4F3syXj6-2puxjUsRmcPuIhwxe03vFc-A6n2I
Message-ID: <CAMtOeKLe-HtjpNze4WPj-knDDZTw3GRq6qMwpig6ygKH+Mq7AQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] Enable CXL PCIe Port Protocol Error handling
 and logging
To: Gregory Price <gourry@gourry.net>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, dan.j.williams@intel.com, 
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com, 
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com, 
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com, 
	lukas@wunner.de, Benjamin.Cheatham@amd.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org, 
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I had tested these series, Thank you Terry.

Tested-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

On Tue, Sep 23, 2025 at 8:59=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Tue, Aug 26, 2025 at 08:35:15PM -0500, Terry Bowman wrote:
> > This patchset adds CXL Protocol Error handling for CXL Ports and update=
s CXL
> > Endpoints (EP) handling. Previous versions of this series can be found =
here:
> > https://lore.kernel.org/linux-cxl/20250626224252.1415009-1-terry.bowman=
@amd.com/
> >
>
> I know there's still some in-flight work, but for the series so far:
>
> Tested-by: Gregory Price <gourry@gourry.net>
>
> Please ping me if major logical rework gets done and i'll roll through it=
 again.
>

