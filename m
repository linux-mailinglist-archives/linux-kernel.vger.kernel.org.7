Return-Path: <linux-kernel+bounces-824328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD967B88ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1926246CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D752ECD13;
	Fri, 19 Sep 2025 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xc/La4vd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D568A2D0274
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275751; cv=none; b=LhKsHGQF1YmGVtB4gElqew/IEUBylKgSHD344W+Qm75tEGKih72tNkMNHce1eHBo8R3MUF8OW5heBUTjvprvS2uSL7/wDjFo3urHN6Can6VVGN5e2CIKx90OzwSyIDIVSzvh85gxocv9c19HY3qYXejN0s2x/kn68l/siZkepcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275751; c=relaxed/simple;
	bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5NKr6LqnWIwF/W9GMW2pODLod0RXwvPcfZrdJjU0RyOVB4PUn/Wa+8ICfIn9Hy1JSy3sQsBeAG+T1XZwSMF2IMRVvuq8EjxKT5V1R+tBysHdVcXTXyMeRQ5X8VqueKXEjNTf9QRuaUZ5BtkxQgzHqsYJtOXnXQNyEH88iRfj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xc/La4vd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so345647466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275748; x=1758880548; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=Xc/La4vdrlq47g21xR53WFqRYbNKRxvRpqWMz3Y1dgypGl1GETmRRc1gSsMiQTe8QI
         mP2gRq+JA8FbBlEb0kGiImEGDR5zbzZQX0/DhqOOWDL2NLwM0ul1p9fVDB8K3UsxJ7Ae
         KN6gTCERtZvkcA3ABafQrmTwGKNmq83YiRQrYjIRkl4XxM8G9ZsVqpovXykhB2gC7PIl
         PktzFAR+Fwbj9960pFz4AxGATYKH1B+iZBoNe1+2CKKmGcoPf4wtUtXSpfyHsgrtdToa
         I5k7NWqEc1JinCsC4lOrsU/8M2/pguLxx07g2io2Av/VHnWZDYXV+roH84QDQDVjbvfe
         oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275748; x=1758880548;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TZZQhYrxGHTiV5iMXlAHEBHgBlMNHInBf4F9FE81hs=;
        b=vUaNGZPwNn9VecUsOBa+/hLzjJzQd5gVn7Hwy47eYUr49PDILZ2J5Ird38BXTFhXNO
         Q45FmdouWArNhD2m37zgs4oN7FTMoDuck1XMSYqb9gEevn+9gz6OnPi+IS9dB9gEfACD
         Q2RmECcxL3BhWsPOxlITulewX8m5ZnWzTSnxzSEAK/cThZKDlZTTcNOC52E0Ln8MLNBR
         +LQOEIkrkm+oF7q3bQl4zMLnqsN5nMu9C9XB8vana707o0dBOcWqxz0hvXnptkytVXv6
         MmZzupMNkeyNqunt81ici/Fx0YYs9tZHKszRf0yTUoXOGps3TdzSw9E03LfzQLGlDJkB
         1eAg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9q75PlXTnucYeXNxKQAPZbRmw2dRmzA5bnh4H12/8BjDPyf1ntzEOVYudbanKG+/GbXpX/C1KhnJSIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFk2GHHw7NISZQRCmMlJIV1TP+hYZo1ZgvHF82l34lAGQm9GQo
	2s+DlR1qVRwXt0EnpOQ5v41xiKsReba9y59snvQj/NEUnknmYITg2WtWD2pLq1mdDOw=
X-Gm-Gg: ASbGncvRXw2QjL9vJX2AvQE8ZFRegwtq532263nGrnqTES8akc/H59dE2CljiBnoOmH
	LWV5Ec5y/6rO+Ih2KWrCvnWrVBHcTj/j8HZalg+XHoxH44TYTroMCgQd0JMwyl0PZfy/aDbI6So
	HmYwly1E72WL1ZdyodTJsSpcmvaEsUwufK5pVjlHqR3r8ozKn8kxZQFuVt3CX0PMaXilfVndo85
	FAiH0/cGi33h42XDKWpD+uDgSeLZMR0j/u0w0CWtZrUC4BFXe0WVS3sxFyh8eQZ9MpaoH2LHpkj
	PQVGALVfsquujoPLi2zJIm71SEGRVXLh5NkQMgGdhaskb9cBCylAAkXwgnuoUpwbGk6WFJqmwx8
	P/0bLGEb3BAk2Y8U=
X-Google-Smtp-Source: AGHT+IE1IHc5VP8kfmcFvlumd42kggIZUzh0BzhhNdnpQ5w+5s6AXkfMgZqLrpodiCERuhqWgn3oMQ==
X-Received: by 2002:a17:907:940e:b0:b07:8972:2122 with SMTP id a640c23a62f3a-b24eedb8c32mr282292566b.18.1758275748062;
        Fri, 19 Sep 2025 02:55:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm76152566b.38.2025.09.19.02.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:55:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: sockmap_redir: Let test
 specify skel's redirect_type
In-Reply-To: <20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:44 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-4-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:55:46 +0200
Message-ID: <87bjn6u5p9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support: allow to
> dynamically switch BPF program's redirect_type. This way, after setting up
> for a redirection, test can make the BPF program skip the actual
> bpf_{sk,msg}_redirect_{map,hash} part and return a specified verdict.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

