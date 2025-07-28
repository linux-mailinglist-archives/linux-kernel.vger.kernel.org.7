Return-Path: <linux-kernel+bounces-748673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD78B1448F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA25C18C0360
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734CA217F53;
	Mon, 28 Jul 2025 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NaBdrsQm"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506021C160
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744112; cv=none; b=WABSS/kCnD/lMglOmLV8vAUMaiYCUO6sQTBW44D1YBLgzh40WpqB8hZ8YLBaJv5HyR+5EL8IyPuiQDlTdduy1kW2rikf9ChzZ9dKQj+ZhDdjHudFy2xko9titJ0fPCZXTG3Qy0obvHTJDmc5F0VLDv2JRIRPMPMis7AQgkC453Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744112; c=relaxed/simple;
	bh=hOXb4gtCl1CYW/VGeucW14FVtx4CfkE0DPqvGmwHY2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiWOQSUA3DMr05HGJD2rXtHaK3kCA9OcpZIHsR4xuzKPYVvR+Sj/kwic8xR3TNPAkFSKjv/rXKL/1YEr5u90OxF+qjqHcQNgZx9hhNXsSTdOx4gy96sN9mZ6Pe+kecpsasfi33zogvBKSZKZcqGbG24R2uJMAWfWb5CnqIwxXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NaBdrsQm; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c3c1d6b-8748-4ae4-8e77-70d7d50c5f9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753744109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOXb4gtCl1CYW/VGeucW14FVtx4CfkE0DPqvGmwHY2I=;
	b=NaBdrsQmvVRtk1YgZLusEv7iP351qv60KO2HFE87dsMee+dgCr2mYQMPl4XrVepw8W+d9Q
	Zb0aX9KUPzGHx/DxppkaYU9F5wx46okpUx8Wiui2P1qxeT+lxO//QojdcotB8LQbRAf01X
	FIGUC6a5021fP1kYpCwh1XD32yO22wg=
Date: Mon, 28 Jul 2025 16:08:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: net_sched: Use the correct
 destructor kfunc type
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-8-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250728202656.559071-8-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/28/25 1:26 PM, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches
> the target function. As bpf_kfree_skb() signature differs from the
> btf_dtor_kfunc_t pointer type used for the destructor calls in
> bpf_obj_free_fields(), add a stub function with the correct type to
> fix the type mismatch.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


