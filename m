Return-Path: <linux-kernel+bounces-737761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F172B0B03A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CDB564908
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BA287248;
	Sat, 19 Jul 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8PcE7pP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3781A7AE3;
	Sat, 19 Jul 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752931486; cv=none; b=gdbetVlhG3EbSzzrAm9FCFhq6KUDj31K1p20Gy1muqYw5DbpgOidbXfJmdsVNH7xlxgOJhheQjW0yfseAlCvKQV56hAWUnvWzvJ8NL066QF55/o1qcaO8xylllSZkmFW2KCFzIuz6uj/gsPUgRW3KMT6XMXt1BKPjvXwI4CIkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752931486; c=relaxed/simple;
	bh=K6ehNrIeWFbo2IhyErHCbxwdJtL8CPLpZhn861VUH1I=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nU1mk6PAKjhH2JJimLcpaH3UjZ+JamM8IcQIbpF15v9pQkpf6n+TwzvDpVtulv43GLR4ToyyN0422d+nMKydYbCq7KWACco0no9RlTsXI6/LJzZKTizKS4XOCWpHRxr6cKSybVUnpknhGqR9/gk82bQQCRrfVEb4RJLRdICehsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8PcE7pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D5AC4CEE3;
	Sat, 19 Jul 2025 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752931486;
	bh=K6ehNrIeWFbo2IhyErHCbxwdJtL8CPLpZhn861VUH1I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Z8PcE7pPpWF/Bf/0ZcbCfDXnDswj+gRhGP/EwCZEzZIP8apc6DmlsTps2OyvxW4Mr
	 yB0rpFUEjN5Rb07ZilqPP4iveE+p4VCoKfA737lJAPRYhPC9DOuvfbQ7xoNS3A2MGn
	 0xNQMBlRs4BmHK0owTCJ8BN9IRdRS9FIKOEkh6txGyfak2T+EPyW/RiyJcDrMGVYsK
	 iRdswvcEIQHcuhalueN7pwesLDCErNkvUC2CussPNG9SXwrE54eemsgcmpxjM8l3Hm
	 TOev1MfDdZRme8lx5cKiSVHuy42U3XIf40xfv5k/0tl9YjrukzzrPqQQBXi+tP94sD
	 StiLiltdTz1yQ==
Date: Sat, 19 Jul 2025 08:24:44 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Orson Zhai <orsonzhai@gmail.com>, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Kevin Tang <kevin.tang@unisoc.com>, devicetree@vger.kernel.org, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Maxime Ripard <mripard@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org
To: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
In-Reply-To: <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
References: <20250719-ums9230-drm-v1-0-e4344a05eb3d@abscue.de>
 <20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de>
Message-Id: <175293148489.4113846.8949388873166546770.robh@kernel.org>
Subject: Re: [PATCH 01/12] dt-bindings: display: sprd: adapt for UMS9230
 support


On Sat, 19 Jul 2025 14:09:37 +0200, Otto Pflüger wrote:
> Add the compatible strings for the display controller found in the
> UMS9230 SoC and bindings for a gate clock. Add IOMMU-related bindings
> to the display-subsystem node.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../bindings/display/sprd/sprd,display-subsystem.yaml  | 11 +++++++++++
>  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml        | 18 +++++++++++++-----
>  .../bindings/display/sprd/sprd,sharkl3-dsi-host.yaml   | 11 ++++++++---
>  3 files changed, 32 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml:38:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml:41:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.example.dtb: dpu@63000000 (sprd,sharkl3-dpu): clocks: [[4294967295, 21], [4294967295, 13]] is too long
	from schema $id: http://devicetree.org/schemas/display/sprd/sprd,sharkl3-dpu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250719-ums9230-drm-v1-1-e4344a05eb3d@abscue.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


