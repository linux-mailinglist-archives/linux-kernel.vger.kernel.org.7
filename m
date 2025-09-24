Return-Path: <linux-kernel+bounces-831248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81543B9C2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E843A168E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E058713D891;
	Wed, 24 Sep 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="joZ0LwVV"
Received: from bout4.ijzerbout.nl (bout4.ijzerbout.nl [91.99.166.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233602FE077
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.99.166.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746706; cv=none; b=j1p4VLL0N4hyAwM71OZcQfHRr/Hns2wwpmBtZ1Yhrgbrie87BE/7pWtpNUW+zlOMFuflX0O4ap27kRl4w4RmtdGAbzJg+Dgpc0YohWH1dX+H2SA2FGfUT8yRMbE6gsmaOpnHRg1zzVZuCR0cBw2pXwtcT4RwJZKBVWt9qZPr9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746706; c=relaxed/simple;
	bh=+W9ee6NkoaXu3UcDGl9X8Whovz/tJ6aDiwbXXN2aka0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT2oPZzYb0tfcdwNgYncBPvWqJFcq35iJHe7u5FiUz4gDq3ogXnT15cdge6rPBCPvCTLFsigdFUaAzr7OdHXqsXTbO/23tLOcUEIxwF9+CBUE0PiRpjQ46XG0OKig2FHkImXkX1mlF2SHMJ8xK+ycQ9C3C0bcMCamG4UC8kaenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=fail smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=joZ0LwVV; arc=none smtp.client-ip=91.99.166.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1758746701; bh=+W9ee6NkoaXu3UcDGl9X8Whovz/tJ6aDiwbXXN2aka0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=joZ0LwVVLYjhdo19MSoDs/C/K0gdffRoiPl49ISJwu1BeZ2oVNlBtdxDuAUwEVsAn
	 M9l8iaNabpKZ8o+M8rZGFXtuXwBZuULvBBvCrdhM2bX/rJ4WXasaT09OboJiHud2K4
	 S/40QARHuhd1Mw4cmUOaf7ZV3Lg3lmmdDZob6tS+yC3gk3Cz79p4DHcchgk/PCQAGl
	 jxvY3mGkqrl1Dq/oUSxm3lI5NsPRRGhYLEDQtyvYPumGPRC+lrYCXBK9zhDgSQRadz
	 NdCtr31sx8TrRL06/pO8wQxDoZxbUKzVv72jvIXuKs5IgrOULGPpZ0q3jOeXGGQERM
	 qXsYyMzCJ0ikLMBRRowz6KnorOysdO13LzmW03TXoc4ex4GTZCaXSqRAh/TqR+080B
	 0yZuziIqlHif2YndSsSCRTqripyDJZDMDsKaEAyWqxT7XQp9yteMb0CI0zIHMKyGG+
	 tfbKYU7oWHBcllNKKrvpBhqhFy2LffVYOHWE8j8cRkG11GoPBKqfaCbyf5MMvWzgbi
	 QKx49xUoNIGd9q9IjUSOp+RVWVnMMB0/KC3/XsAvMNj2BM502Y9bMKP+Izf13fSi8I
	 p3yRD1ipUrQOKbGPxuv9LtL9wTjdawLy7idDFW4A0MQprt8tFSYCLNWdcHf1N6Zd6T
	 SUoV/6mwD3hq4N2f8xTq6Jg0=
Received: from [192.168.178.251] (ijzerbout.connected.by.freedominter.net [185.238.128.139])
	by bout4.ijzerbout.nl (Postfix) with ESMTPSA id 8E81B41332;
	Wed, 24 Sep 2025 22:45:00 +0200 (CEST)
Message-ID: <e6da8bc1-12d2-433e-ad20-095c291e03d4@ijzerbout.nl>
Date: Wed, 24 Sep 2025 22:44:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 9/9] drm/xe/xe_late_bind_fw: Extract and print version
 info
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 alexander.usyskin@intel.com, gregkh@linuxfoundation.org,
 daniele.ceraolospurio@intel.com, mika.westerberg@linux.intel.com,
 lucas.demarchi@intel.com, karthik.poosa@intel.com
References: <20250905154953.3974335-1-badal.nilawar@intel.com>
 <20250905154953.3974335-10-badal.nilawar@intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250905154953.3974335-10-badal.nilawar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 05-09-2025 om 17:49 schreef Badal Nilawar:
> Extract and print version info of the late binding binary.
>
> v2: Some refinements (Daniele)
>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_late_bind_fw.c       | 124 +++++++++++++++++++++
>   drivers/gpu/drm/xe/xe_late_bind_fw_types.h |   3 +
>   drivers/gpu/drm/xe/xe_uc_fw_abi.h          |  66 +++++++++++
>   3 files changed, 193 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
> index 0f062008ca83..38f3feb2aecd 100644
> --- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
> +++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
> @@ -45,6 +45,121 @@ late_bind_to_xe(struct xe_late_bind *late_bind)
>   	return container_of(late_bind, struct xe_device, late_bind);
>   }
>   
> +static struct xe_device *
> +late_bind_fw_to_xe(struct xe_late_bind_fw *lb_fw)
> +{
> +	return container_of(lb_fw, struct xe_device, late_bind.late_bind_fw[lb_fw->id]);
> +}
> +
> +/* Refer to the "Late Bind based Firmware Layout" documentation entry for details */
> +static int parse_cpd_header(struct xe_late_bind_fw *lb_fw,
> +			    const void *data, size_t size, const char *manifest_entry)
> +{
> +	struct xe_device *xe = late_bind_fw_to_xe(lb_fw);
> +	const struct gsc_cpd_header_v2 *header = data;
> +	const struct gsc_manifest_header *manifest;
> +	const struct gsc_cpd_entry *entry;
> +	size_t min_size = sizeof(*header);
> +	u32 offset;
> +	int i;
> +
> +	/* manifest_entry is mandatory */
> +	xe_assert(xe, manifest_entry);
> +
> +	if (size < min_size || header->header_marker != GSC_CPD_HEADER_MARKER)
> +		return -ENOENT;
> +
> +	if (header->header_length < sizeof(struct gsc_cpd_header_v2)) {
> +		drm_err(&xe->drm, "%s late binding fw: Invalid CPD header length %u!\n",
> +			fw_id_to_name[lb_fw->id], header->header_length);
> +		return -EINVAL;
> +	}
> +
> +	min_size = header->header_length + sizeof(struct gsc_cpd_entry) * header->num_of_entries;
> +	if (size < min_size) {
> +		drm_err(&xe->drm, "%s late binding fw: too small! %zu < %zu\n",
> +			fw_id_to_name[lb_fw->id], size, min_size);
> +		return -ENODATA;
> +	}
> +
> +	/* Look for the manifest first */
> +	entry = (void *)header + header->header_length;
> +	for (i = 0; i < header->num_of_entries; i++, entry++)
> +		if (strcmp(entry->name, manifest_entry) == 0)
> +			offset = entry->offset & GSC_CPD_ENTRY_OFFSET_MASK;
> +
> +	if (!offset) {
This for loop looks suspicious. Do you continue the loop on purpose
after finding the first match? Or should there be a break?
Also, if there is no match then offset is uninitialized. Isn't it better
to initialize offset at the start?
-- 
Kees

