Return-Path: <linux-kernel+bounces-865022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE3BFC065
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9873B188B01D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB5355813;
	Wed, 22 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGF9O2Ow"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89D34A784
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137767; cv=none; b=aEk8c+F8McGSDreRubvWbMaRBDpu4tmLaB6O7mAjlHMNGdcCc+jaPW3T3Y/wBr58pYrZfSOXy5ZVhk8BmCojzS5v9aXszxcQ8FcJRQySg7ZpUX0v04MHzSx3FztGD/LnnXnXDI8gPna6Pb5zArIq0ZW1X6pdlSRApkf4ThlWph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137767; c=relaxed/simple;
	bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oThAGo0GZxr8OlgOeawSXQhILjnQwDxBJYUaliyAvE/3KXvcJsaenXvFRHOr1PW+jeFBECDnuNmRI7/ZMVMocCMnd5pfHsgLswZDtO8DRDeYpajuwpZaWbGe4c8bWK4XuPCwyKndl6O+9qfIf9gTkgpvlcMmhOfgcLPAlRbz4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGF9O2Ow; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67684e2904so4832642a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761137765; x=1761742565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
        b=BGF9O2OwETToO33KLhtkS4GfP1axe7S3jilxDDoEbVe5mh1qiMKOedeftrQgdl/qKK
         4KULqF7CSImOTz8PjMH7joKKyO1lkQnZM6dzAnIBX/H54V0c5FfYCq7F8pO53cvVSzWZ
         k+ZH+MUzc/w5zftoKuM4FCm1w3Wgu3/eslyrv8ihLV/Gvm6iQ0NMI9dDf+iNcQnUlYhf
         WiREEhy2cB+Hnt/dqS9qmrna+q9to2jjn8X7kNjUeBcsAu2vBaIAXozsoIHVnCClhL2R
         oAV+NuNIsQ1pP6kgei0r30PnzVyYElvCD51w6vOLHCKRH90eWUKV9lE8FzXe8p6GaH81
         nHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137765; x=1761742565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55Djqf35I/K3RxxLzdcQP6qMdW/uYAdfSQFf+LthStU=;
        b=TNytVd7gRKAwoy/18wkDdnXH/qqHLdyIOvxt2pY2SnoHN5VcE6obdO9v7IOK1BT0wR
         40Iq0VIE3fdbIPRucd2oX3f8i2jfWJaIYvDEGz9D28ZEqLV73ACQuz9Xxu1Zxq/QpUpV
         513nyx1x7skLW06/JS+GBzD4F/YogQ+B+pG96s6uyR2/dtlaBPcfzSCdcifqnD2ngsTd
         g45dxkpwaOzuIh7KLkRRLhFSLjlTA1mX3RLMrf3XqkjpErQ9/DP1Yh3wSYciPPECBDAg
         2ECEVUHHNnCk7zDimIWmAbym+ZSs3gX/wHS/Q0FZDOVNzihnJcN0x0JXyB7cfmuoGBmm
         llZw==
X-Forwarded-Encrypted: i=1; AJvYcCUwV5R1WhhXssQiJTJnGI6wW9UkaLFNyYdkluEyiJrQTu3y9+FUKUQM5pd62u/+tr3Km9XkUE5HP6Zl8jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyky/mH64y12yXIxQ8h9qUcvA6kWZlA2us+cqUaDmeikbXGZAlo
	+7wJMNNe8nyWT7cQ1cB9nadD4PlGM4nh38Eahc4xenO4V4HzbwKXw3La
X-Gm-Gg: ASbGncuFmMhLcSUjCNVmTKXrYrrX+fD1+M31npgw68sHm2euscSaDeQmWglcHIr3fvC
	Nw6YaXO6mYnbcPQOeeIWv3dpAXyz5rOyknol3lOMUeFAmKMht2DRpKI1UIwEV3xDyZCf+/QU5XM
	U69fVhmoZgOo/S5TKJv3Ael+WZtyrZPRG/HcsL241/5+A2PVURmhvbKeLZOuvrO+5BOlczUr3CM
	k/m1+XSKEhpkU73VRJOht/uGQDkvKQmT+H0WPXNZoRlhxAEYouVL7YwxBuid75B3S/wabJPfXRl
	mHRXhkGwlrKQhqpO1RJ80RP1g8zxyKj8OHz2VKkgMUuLNoopXLRzw2z73yMAHbnhG2pwc1T+2Fd
	SbTVxCzvFBNyvL7M+9WvHU6kEBWPLaChxOxfpUQtq1AWO/ShmsUSr7y3ylMq5POlTgfXvavN3NE
	cWJiLdw8kz389hAw==
X-Google-Smtp-Source: AGHT+IFAbriApVOx8o8gcjpfk2lo+t2/yibaJf5nwAMFzyuHbx4XWsOEML5CUbO64FfcWtaVnEq9gQ==
X-Received: by 2002:a17:902:f78f:b0:290:af0e:1183 with SMTP id d9443c01a7336-290cb65c5e7mr213748355ad.51.1761137764590;
        Wed, 22 Oct 2025 05:56:04 -0700 (PDT)
Received: from [172.20.10.5] ([117.20.154.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247218eafsm137558455ad.101.2025.10.22.05.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 05:56:03 -0700 (PDT)
Message-ID: <8764fe64-d896-460e-8e0c-cd81667c57b9@gmail.com>
Date: Wed, 22 Oct 2025 20:55:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add kfuncs for detecting execution
 context
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251022113412.352307-1-jiayuan.chen@linux.dev>
 <20251022113412.352307-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20251022113412.352307-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/10/22 19:33, Jiayuan Chen wrote:
> This path introduces several kfuncs to help BPF programs determine their
> current execution context. When hooking functions for statistics, we often
> need to use current->comm to get the process name.
>
> However, these hooked functions can be called from either process context
> or interrupt context. When called from interrupt context, the current we
> obtain may refer to the process that was interrupted, which may not be
> what we need.
>
> These new kfuncs expose APIs that allow users to determine the actual
> execution context.

Hi Jiayuan,

Rather than introducing multiple kfuncs to determine the current
execution context, this can already be achieved by using the
'bpf_this_cpu_ptr()' helper to read the underlying preemption count.

Please refer to my earlier patch,
"selftests/bpf: Introduce experimental bpf_in_interrupt()"[1], which
demonstrates this approach.

Links:
[1] https://lore.kernel.org/bpf/20250903140438.59517-1-leon.hwang@linux.dev/

Thanks,
Leon

[...]

