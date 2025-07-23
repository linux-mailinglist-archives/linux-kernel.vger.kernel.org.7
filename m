Return-Path: <linux-kernel+bounces-742928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86383B0F854
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD677B5ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268E1FECBA;
	Wed, 23 Jul 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="plnHbUig"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921C31FAC4D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289032; cv=none; b=Y75a1Qy6n/lA/5GHWFOTGMyra0dJDbpShVwkt/mYP2exq67QFZmiJ1KsXN9iMBUnQCz6vqWJShNeow9ol4uP/nHUvhhiYo3Ul4uOmp/bwSIF52Z9EcaRG0r5JNM/GYPA2M2Y6+rNv+BboSK4YpR8EWdZvkw7tZXshzezAVGC/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289032; c=relaxed/simple;
	bh=guy1THaqZXr+J9mp8qz0W034I+DBqK33XEmscipM+H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lof0HtEgoyIaiqLA47mZuKdHhxu51pttlP8I3eGwmV8RsOMfX7HluPsFxRrzR9z9kdaV+SWSUpU3QSKL52J4GyUi70OQqOYL3oUxARtDBlT5PNO+YIHI5KcW1kDDACfQtqWZ+I8od6khR7M6pSTkWJ02/TAEaz6RJpHRVski2nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=plnHbUig; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87b26791-5a3c-49b2-9d02-a8b42a22e0f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753289028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ekh9tl/P8hIJmxG1pXhqX01V9iSOurqGVnHpkN4ek0=;
	b=plnHbUigAYs6bYqaIH+1khT1EVQFLKnYGkgiVvG8l+9ge8oAzNbcbiXEss3OFjL19YXINK
	fLPXnuMlrwUFDSkL/MSNmZtKKLJMz0vrSiolh8yAtjt4p01cmbHfSx++xD0UrHyp79f2o+
	av92OLYu+bMYwAWC6TMrbpPyaSZco2Q=
Date: Wed, 23 Jul 2025 09:43:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Migrate fexit_noreturns
 case into tracing_failure test suite
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-5-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-5-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> Delete fexit_noreturns.c files and migrate the cases into
> tracing_failure.c files.
>
> The result:
>
>   $ tools/testing/selftests/bpf/test_progs -t tracing_failure/fexit_noreturns
>   #467/4   tracing_failure/fexit_noreturns:OK
>   #467     tracing_failure:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


