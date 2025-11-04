Return-Path: <linux-kernel+bounces-885599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205CC336D5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D262D4EE219
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87334B1BE;
	Tue,  4 Nov 2025 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="Yrs/ysbr"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4A72605
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300235; cv=none; b=NEMNQmziwoHrKhZCDEtBYfMWE5GzfoRfhdXiGThq3wBcqZqgAdS6g3z4EV5V8hjXQGEtUbGYSaNwyOMbS9148VdhbuD+AdxGIs7lyedmYcClcrfWMcNjD0YwBEF0/G9EHVIm0hVlziJ5/3f3VczuIHi2p4447TvYCn0ABvUHOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300235; c=relaxed/simple;
	bh=yrp3V8F5KFfG2cdn3D4XyDIqmTPco+SmEUrqRPdrkCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHXarhzMnw77Ot8X/t99de02UNErUA1f0/b9OLnpkOf2zeu5GLMLkaDPOb3xtXIUneAz81Fw3x2o1HEqYNJIhgtxB6AL9U4JXUxYjTF4eekGr7IO2OJHOdLdCZi6tRTqC/tK+cwOF/Nf+FUAD/oSbA5RMZigYEySjtNquFxf/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=Yrs/ysbr; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <7d26e4e9-e298-4991-883f-ceb60f240394@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762300230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa38TozYLzaYiqdoQXWeYcZaoruV3Zdpfxo7PyItnNM=;
	b=Yrs/ysbrG26Ed0ngsAd3+u8pbekgXo+zrGKYb8WZiXkD4c+TmhRCiDBgaLMZXuqFp/OPtQ
	WaBSVGmKRIRXT57JDb3Z1o9R7MPWWr/OmVWlRkKfExwLpweL2yuY3nd3zMbb/6plJ31nXD
	m+vZ7nhQPc58GUGLyUXoKliVVdD+M3KVvTnqA5AmXOnKIQhwDh0QyUHjyV3/B4rX574ONP
	8XxOvw/Y2EfrSKAmmeDqXZCrkDhBbXppzUPmyMb5SrcLixWJ6ElZOM0jHsUJNqL2jQiSUX
	jJXPePQSShR9aK6ovX11/rBLYJwDoFHhRHdmFLh820rYza1KGrVUjNtDLlmljw==
Date: Tue, 4 Nov 2025 20:50:20 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/4/25 2:11 AM, Dikshita Agarwal wrote:
> [..]
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -91,12 +91,13 @@ int iris_process_streamon_input(struct iris_inst *inst)
>   int iris_process_streamon_output(struct iris_inst *inst)
>   {
>   	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> -	bool drain_active = false, drc_active = false;
>   	enum iris_inst_sub_state clear_sub_state = 0;
>   	int ret = 0;
>
> [..]

Somehow, you have lost the + edited line that declares the bools.. Hence 
the CI failure reported for v1, and the kernel test robot message from 
just a couple minutes ago.

But with `bool first_ipsc = false, drain_active = false, drc_active = 
false;` filled in,

Tested-by: Val Packett <val@packett.cool>

finally the decoder is actually usable \o/

~val


