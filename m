Return-Path: <linux-kernel+bounces-738521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CFB0B994
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1DA7AA244
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5374059;
	Mon, 21 Jul 2025 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgvaLMV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA123FC7;
	Mon, 21 Jul 2025 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753058166; cv=none; b=a00MfH335N9Kwh3Qd5HfY5gS6xgzcqGHuzAtE+fuFK9sXgqvroJZNXjvrk8sxSSpw2GtBpRcOBGLePPCNCeHhQ4Y9t8oUTeZKBKJBjVAzNwL/+ygGVguPmsum0H4CzD42IYi0M5suAotDujdY1hhmuCotnMTS2S/BRo22gcw2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753058166; c=relaxed/simple;
	bh=gKSahrtOCSt/VKfd9xs5pD7+wJwsmP69I2iSsDQw5Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCxPkpcLR0T6mvVRDr7MDsFHgxVSR/PsWGiWTsxruVR095Jojol+9x94KzfROWjKRlttLWMGzKH9E+2M0qysS5T0fd1kdXFwb9rDGteq175Cbs3h0eonj8v/WrTt7JrIkQNQdNOJCSEdFJvFC+ECNgvIkio/ZLLq+OBRVajpG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgvaLMV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB2C4CEE7;
	Mon, 21 Jul 2025 00:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753058165;
	bh=gKSahrtOCSt/VKfd9xs5pD7+wJwsmP69I2iSsDQw5Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgvaLMV8vSyyb4YaYe8T5Mk3QLjPB/mLj5woIrOlN9iVpS2eZWe1JGrdf5Z3XLDrg
	 SYMf9wYyGN+zML83heWmCvSciJakgxGBj7aRYha/lpSlk+QkoCmpj5NsDFCXy17bMA
	 AlFT1H35PpvdtG7HcSAk/CJ/Nqr3kYhUIZBb7W/DOJ1T7iqUFFEzeqDsvDTgRAyl+8
	 IYPSQqi8NXAVpvqKpy7bcUa23VDSFZX8nn+Ss4EYBvzpjSVOdQRtjUNgtTNWF37HWq
	 s+kfUOhXNumM0OYCQsN7P7M+w/ER4tHcn8m7t1aYuxXXTmhvtqkLEhrVe4o57A0Qcp
	 ZH70Czzi/xQiw==
Date: Sun, 20 Jul 2025 19:36:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: git@xilinx.com, Conor Dooley <conor+dt@kernel.org>, monstr@monstr.eu,
	linux-kernel@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, michal.simek@xilinx.com
Subject: Re: [PATCH 1/3] dt-bindings: soc: xilinx: Add support for K24, KR260
 and KD240 CCs
Message-ID: <175305816440.3147094.10086581132986063188.robh@kernel.org>
References: <cover.1752837842.git.michal.simek@amd.com>
 <8ff66d0dc4e0de6f239c25d43a2a96b4224305e8.1752837842.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff66d0dc4e0de6f239c25d43a2a96b4224305e8.1752837842.git.michal.simek@amd.com>


On Fri, 18 Jul 2025 13:24:06 +0200, Michal Simek wrote:
> The commit 7a4c31ee877a ("arm64: zynqmp: Add support for Xilinx Kria SOM
> board") has added support for k26 and kv260 and the commit dbcd27526e6a
> ("dt-bindings: soc: xilinx: Add support for KV260 CC") has added support
> for KV260 and this is follow up patch for adding description for k24 SOM,
> KR260 (robotics platform) and KD240 (driver platform).
> The bootflow is the same that's why for more information please take a look
> at above commits.
> 
> The KD240 kit is based on smaller k24 SOM with only 2GB of memory.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../bindings/soc/xilinx/xilinx.yaml           | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


