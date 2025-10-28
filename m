Return-Path: <linux-kernel+bounces-874233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19281C15D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B708F403B71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04682877DA;
	Tue, 28 Oct 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B9zf4fnZ"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D122A1D5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668685; cv=none; b=FuWgc5TavMZktH7K3rtS15R7hrWtxoM9+BZPicHHv6IFdcfplYcXoeQNzFZlc1GayfQaLP+sLUDGdLDHfzZhT71aeEzwGLFVmwU2EmskMFYNCDj7CBn1zarJHYP4o+445RxxoiETwNCOmJNH2KI0AstWwrV3hpAJY689VuOFR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668685; c=relaxed/simple;
	bh=HNLCSr4FXQd/7ll40qCSdRZ4P9xFpVh1iCX5RuPBAzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNvOqrofVmH7GWnibUEYA2dgbJnYD2zuOVvoqJ+V50Ol0hYc3h5KZ3Z2S0TmH7MLwlhA2AZKMl7elEdjuU9n1j1ziOntQK93EV+F9bETYJ1nwh92YUAGBMbO0leflzEtH2aZlYhxGAvR7MUmAvvfQswllfZG/vMMOtPRvqiZHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B9zf4fnZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01719c2d-ddd1-4f96-8bae-40144f0410c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNLCSr4FXQd/7ll40qCSdRZ4P9xFpVh1iCX5RuPBAzw=;
	b=B9zf4fnZva6RF7EwZrAdUUCNqXhMYSXOaX1qOloois9lkiJH3PuoKnP4QWQOxHRMwLNGUe
	w18ht4zhn94tcAqMyhImUmdOhC/o7bpR7XjkwhLSVaR3bMZeXxs1JZnOzD7uELn7Y8IfxC
	Bo8sPxicr6CBWCud2HMDjTzvhAJ2Guk=
Date: Tue, 28 Oct 2025 09:24:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
Content-Language: en-GB
To: Jianyun Gao <jianyungao89@gmail.com>, linux-kernel@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
References: <20251024080802.642189-1-jianyungao89@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251024080802.642189-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/24/25 1:08 AM, Jianyun Gao wrote:
> In the elf_sec_data() function, the input parameter 'scn' will be
> evaluated. If it is NULL, then it will directly return NULL. Therefore,
> the return value of the elf_sec_data() function already takes into
> account the case where the input parameter scn is NULL. Therefore,
> subsequently, the code only needs to check whether the return value of
> the elf_sec_data() function is NULL.
>
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


