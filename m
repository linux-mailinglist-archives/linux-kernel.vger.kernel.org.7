Return-Path: <linux-kernel+bounces-877481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE3C1E332
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E06A4E3919
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845829D291;
	Thu, 30 Oct 2025 03:28:22 +0000 (UTC)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A52264DC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794902; cv=none; b=VGf+zjMdWfHwmtdLtKRfHjJIhmjGdmd+20P1+35xtHRJ9e8J7h4CO9rojnAzguqoAGddxmAorkqRsIPfP+ZcaxLxosDq5BG6mA6yljozE0L9EKaeaK7ylX9j0l1Qao0FoRAx1De+Eypw6cBQ7B1JDHho54oqPkLTDbXCulaqVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794902; c=relaxed/simple;
	bh=ZRwsoDODDDkoyUVw9jZogJ+/+K8HHSV4Lf9blPtqaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfhmWn2wYrUiYLq0uAVViHWGvK4tK9n6IexFhWzlR0+ekIqcjShFnAs2fhIi0PdhZBRSPNLvbKMdqS66LfaZs9Cr+a2nHWWq8znCNTwOtHg6L70JqawPaFYpNWl51A0P7QEUUYd4nhIEcIBPdp9FeLIAk6rZ1X4y3uWouvFVlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn; spf=pass smtp.mailfrom=bosc.ac.cn; arc=none smtp.client-ip=115.124.28.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bosc.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bosc.ac.cn
Received: from 172.38.11.120(mailfrom:zhangzhijie@bosc.ac.cn fp:SMTPD_---.fAeuCRr_1761794886 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 11:28:07 +0800
Message-ID: <889561a0-cf44-4a17-a7c2-095408006bf3@bosc.ac.cn>
Date: Thu, 30 Oct 2025 11:28:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Support Intel Xe GPU dirver Porting on RISC-V
 Architecture
To: Jeff Geerling <jeff@jeffgeerling.com>
Cc: wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, daniel@ffwll.ch,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250715061837.2144388-1-zhangzhijie@bosc.ac.cn>
 <C67D4EC2-649C-4E46-A55D-8B48A31E8928@jeffgeerling.com>
Content-Language: en-US
From: ZhangZhiJie <zhangzhijie@bosc.ac.cn>
In-Reply-To: <C67D4EC2-649C-4E46-A55D-8B48A31E8928@jeffgeerling.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/30 09:55, Jeff Geerling wrote:
> +1 for this patch, as it would enable Xe on any non-x86 system.
> 
> I've successfully tested this change on Ampere and Broadcom (Raspberry Pi) systems.
> 
> We've been using the flag `CONFIG_VGA_CONSOLE` instead of `CONFIG_X86` but either should achieve the same goal. See: https://github.com/6by9/linux/commit/6bd4cfe79b5111986dd11a5c6e48d4a963fd7740
> 
> With some OSes a later Mesa version needs to be compiled to support newer Xe/Xe2 cards, however I've successfully tested a number of Intel dGPUs at this point. Sometimes setting force probe to '*' (or the particular GPU ID) is required, but otherwise stability is good.
> 
> For example, the A750: https://github.com/geerlingguy/raspberry-pi-pcie-devices/issues/510#issuecomment-3383284831
> 
>> On Jul 15, 2025, at 1:18 AM, zhangzhijie <zhangzhijie@bosc.ac.cn> wrote:
>>
>>     inb/outb speccial wire not support on other ARCH.
>> Should detect whether arch platform support or not.
>>
>> Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
>> ---
>> drivers/gpu/drm/i915/display/intel_vga.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
>> index 4b98833bfa8c..5e48e3282670 100644
>> --- a/drivers/gpu/drm/i915/display/intel_vga.c
>> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
>> @@ -33,6 +33,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
>> if (intel_de_read(dev_priv, vga_reg) & VGA_DISP_DISABLE)
>> return;
>>
>> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
>> /* WaEnableVGAAccessThroughIOPort:ctg,elk,ilk,snb,ivb,vlv,hsw */
>> vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>> outb(0x01, VGA_SEQ_I);
>> @@ -40,6 +41,7 @@ void intel_vga_disable(struct drm_i915_private *dev_priv)
>> outb(sr1 | VGA_SR01_SCREEN_OFF, VGA_SEQ_D);
>> vga_put(pdev, VGA_RSRC_LEGACY_IO);
>> udelay(300);
>> +#endif
>>
>> intel_de_write(dev_priv, vga_reg, VGA_DISP_DISABLE);
>> intel_de_posting_read(dev_priv, vga_reg);
>> @@ -80,6 +82,7 @@ void intel_vga_redisable(struct drm_i915_private *i915)
>>
>> void intel_vga_reset_io_mem(struct drm_i915_private *i915)
>> {
>> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
>> struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>>
>> /*
>> @@ -95,6 +98,7 @@ void intel_vga_reset_io_mem(struct drm_i915_private *i915)
>> vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>> outb(inb(VGA_MIS_R), VGA_MIS_W);
>> vga_put(pdev, VGA_RSRC_LEGACY_IO);
>> +#endif
>> }
>>
>> int intel_vga_register(struct drm_i915_private *i915)
>> -- 
>> 2.34.1
>>
>>
Congratulation! . So I think shoule be disable this ops or take other 
ways to instead this code， Like None IO soc/ARCH

