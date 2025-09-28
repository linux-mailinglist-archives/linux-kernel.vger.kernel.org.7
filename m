Return-Path: <linux-kernel+bounces-835147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A65BA660C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B507177AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1024677B;
	Sun, 28 Sep 2025 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHEFSQkp"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F07243964
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025235; cv=none; b=Kd91MZpSmTgG9cYKBQvW1TIMMtGCzpeghxpZYfy3ZNz0q1Bc+uypG4XxJJkdeaAi29LkBnb+e4EnQwZoakRDx6GU5BTeceqLjNt3ZO2JjtZly+p8Pm7L1GQP80x7QfmxeAN9UTEQUEu3YT0jnlvS+cTEek40gNyFXXWmj8IWw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025235; c=relaxed/simple;
	bh=SP2JQxDnsE15QW4Z8D/yogNvPwBxNop/wuQ8+8eP1VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjMLmU0T2xD6V3dCNsmHdkFGfN2PbwQr6RGonVCddHHm+H197UNq6ecJti0L8GjayGkfwAHQ8CD1hN592YGQQgJ3XpHmWGv7LlhReoIkwoSPcRhPGHrtn94onOiVBUVIEqbDxh0l5soQDkuiaqN5GxsnWsFDTXUvNjRMa3NKRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHEFSQkp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4aba00a3-cc60-4512-9e84-49c08817edbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759025222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuGH4sXGP/w2R5AcXujaq0+4DAeVcKUSVlZq3q7jypQ=;
	b=tHEFSQkptFl38iTGN4275Azkip/CpFg1fwP1tE8pooxtdx9ULmKVelHWVXzjlaW3fb0Vst
	qhKOze1w++3rGbKf71g+Gabnk4cQI2KY73P4bNBe5BexSf9DDjuLkoynQuDmhXucfog8yp
	9VzDxHD7oxu4QZQzNqiqCEAOXlG4z1w=
Date: Sat, 27 Sep 2025 19:06:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 rdma-rc] RDMA/bnxt_re: Fix a potential memory leak in
 destroy_gsi_sqp
To: YanLong Dai <daiyanlong@kylinos.cn>, kalesh-anakkur.purayil@broadcom.com
Cc: jgg@ziepe.ca, leon@kernel.org, dyl_wlc@163.com,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 selvin.xavier@broadcom.com
References: <f207b88c-da98-4fe2-b91f-ed07354ff019@linux.dev>
 <20250928011148.4593-1-daiyanlong@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250928011148.4593-1-daiyanlong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/27 18:11, YanLong Dai 写道:
> Hi Kalesh, Yanjun
>
> Thank you both for your time and reviews.
>
> On Wed, Sep 24, 2025 at 10:31:34 +0530, Kalesh wrote:
>> Hi YanLong,
>>
>> Few generic guidelines.
>>
>> 1. You should select a target tree in the subject prefix and specify a revision number. Since this is a bug fix, the target tree should be "rdma-rc".
>> 2. When you send an updated version of the patch, please mention version number. Also, mention the changes made in each version. i.e. under --- you can add extra info that will not be included in the actual commit, e.g. changes between each version of patches.
>>
>> One comment in line.
> Thank you so much for your patience and guidance throughout this process.
>
> I have incorporated all of your suggestions in this v2 version:
> - Added the "rdma-rc" target tree prefix in the subject line
> - Used proper version numbering (v2)
> - Included the changelog below the '---' line as recommended
>
> Gentle ping on this patch.
> For easy reference, the patch is available on lore.kernel.org here:
> https://lore.kernel.org/all/20250924061444.11288-1-daiyanlong@kylinos.cn/
>
>
> ---
>
>
> On Fri, Sep 26, 2025 at 09:11:11AM -0700, Yanjun wrote:
>> Hi, YanLong
>>
>> In regions where Chinese is not supported, the email may appear garbled.
>> We recommend replacing any Chinese content in the email with the
>> corresponding English to ensure clarity.
>>
>> Thanks a lot.
>> Yanjun.Zhu
> Thank you for the reminder.
> I have replaced all the Chinese content in my previous email with English to ensure clarity and avoid any encoding issues.

Thanks a lot. The mail looks better. I am fine with this.

Yanjun.Zhu

>
>
> Best regards,
> YanLong Dai
>
-- 
Best Regards,
Yanjun.Zhu


