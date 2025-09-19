Return-Path: <linux-kernel+bounces-824320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC02B88A65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F96A16EBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92C2264D5;
	Fri, 19 Sep 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SoxxNhd4"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC97082D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275389; cv=none; b=VLJ6mwj5uLuB34mk7JYCB4egeSNWhotJ/O1tOoKqPOF0WVhh8DB4yun+tEUNMaAwbBYv3pvJoqiSwf+tObv/yeDJfM43ixVpJG1yNp+DRAm3zw5g/rpXi6+pWXZg3PjJobLBQgZNg7tAw4Xo/HwyQ4YCLyKNF2HmFrVIkoJudNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275389; c=relaxed/simple;
	bh=+vn2beOL9iMmMYtBKIdblfpGt0ByFQU+AXOHY7wMakQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sN+jtHwjEz6FijABpoBuNt8MD/Ye/juIYyPmZLuo0KYAExV/Aobb77IRaa5PCI9Z0yoscGuCo39ldKgI9clFWZLCbPNtD/mI7uLF9/RZroCThz74NKrM9mnPqcX00vpZqI5srmCv+Cg/ikDdSRMJQ02TQJfyc+5s8zUPOOviu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SoxxNhd4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7238b5d5780so24966257b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275387; x=1758880187; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=SoxxNhd4qxOPCLTfLfMyg6V9quHrYYl76RID6alKKtBo6kSdEaRQ6YS1QrseFaoY7P
         CJhZdQcB54vDQQ2IdGSiEov7Qn1vi8frxMjWyIYszXAZmPk8U1VjXO3bLAKDiVur/3Ro
         GZACoi0x6f5tFzeY/IA9M9u9q+7qV4RLZkU3BhfW8EPmvhF6gB5IwMWzPEcjTNLf9Joa
         CaNhs8DNsoJgYaUkdrxLZlAy+uyuOtkQqfoGVQe7uXmPDREcI0cs0mQDhzPuiY7CoUe5
         q6CkNkg7MMMIQ3WB3tOCNoGQFb02gUXSKl5B4PD7D2FJL80fxULaKHo/EtzK6getU9Op
         dhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275387; x=1758880187;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlTmVi594nSn7MW0oziVF2PMwb+/b26nYZTh/X3jURo=;
        b=ngDCq2CRjjF+BXkOiTvZz5GRli6LFFjCfzNrNYPniivX5LfJvowBtNSbT55IvzXW5m
         fHGlTDzC0t931PIo8TsyO21geRpIY/QsfLW/lKWSqqc/2Nt4OP75WFZ/gntyTCYnSexO
         2J5hqHCUiEPKpAvUzwL1FcRLMtasfLB5cxurBOLf8FWk4EA3NrXpzVIXW4T9g0KZJNBl
         URMm7sOnw5MWjPzCVujcM4ga38cmB3IH9QzXq4vK1WKLrFucMj1jMELVTisSN8Yc5Gsq
         NsEJlhFmoBBcUdHZnQeFnUwtB3AeEWar+JTOrDZAV4VjtH3kd8E5XGu4Vv6RBjfzH3cK
         Tekg==
X-Forwarded-Encrypted: i=1; AJvYcCUbQmC+yYk00u14WTZoppZjzmBQs6toQOufe86j691rNNv0pZ/8wtZc2Fb/h0VF9k5XcvahcZfAY0qKT0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdJ2w6kF3ucj7PDQQaJvKKgzH5jCEh4dmdhZZtjc0/grtDIZ0
	6dVh5X2sO8pkwk1nFRet5vujhogJ3wWXRT5mQiixjys7gmmeuJn9lrv8yGvfm/IZii8=
X-Gm-Gg: ASbGncuY4SqCyqws8oxQwT810Je1TTICKAAghkqNPLSsDhzVEzXXlmq9zftnj6ITi1B
	s1mTM1aAHj5XG/8MFnqLhEKUBEufdHEGbJsUq0glT5yVniFBndpzwWrCSReRelB3HvEw5575AcY
	nSqXBlRttAPT56FUF8pU1qJBPlobZOwe13oQC726rII6RXwB5pwRZN64Jhn8LE649bJRkMw6bVl
	iv4rnkuHsqzBodfLGQXh7ijvjZ86p3OYlQCf6plc1EeCdZy1/gEaWa933nXVcHK+mj40rQldORZ
	Cty9poHeJfBxUbITHdEa4xqyE4rD3bK3B22t09n7riiPEeGMMvFSZquaiMuwZG6M0Wn+3mIVHR3
	cAx+QOzjIrZfOgw==
X-Google-Smtp-Source: AGHT+IFpVVlH/GN9+lAL03mMctGhSJiZkSMnotDqIFxVyomur2G0cmwXdfQol97zehSveNubfzRMoQ==
X-Received: by 2002:a05:690c:2502:b0:71a:2a13:1e44 with SMTP id 00721157ae682-73cc45b4c3cmr26463757b3.4.1758275386983;
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcd08b24sm1610356d50.8.2025.09.19.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:49:46 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: sockmap_redir: Fix OOB
 handling
In-Reply-To: <20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:42 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-2-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:49:44 +0200
Message-ID: <87jz1uu5zb.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry for the super-long time-to-feedback.

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> In some test cases, OOB packets might have been left unread. Flush them out
> and introduce additional checks.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockmap_redir.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> index c1bf1076e8152b7d83c3e07e2dce746b5a39cf7e..4997e72c14345b274367f3f2f4115c39d1ae48c9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_redir.c
> @@ -184,6 +184,19 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  			FAIL_ERRNO("unsupported: packet missing, retval=%zd", n);
>  	}
>  
> +	/* af_unix send("ab", MSG_OOB) spits out 2 packets, but only the latter
> +	 * ("b") is designated OOB. If the peer is in a sockmap, the OOB packet
> +	 * will be silently dropped. Otherwise OOB stays in the queue and should
> +	 * be taken care of.
> +	 */
> +	if ((send_flags & MSG_OOB) && !pass && !drop) {

Nit: There's a similar check a few lines before that:

	if (pass == 0 && drop == 0 && (status & UNSUPPORTED_RACY_VERD)) {

For readability it might make sense to introduce a helper flag:

        bool no_verdict = !pass && !drop; /* prog didn't run */

> +		errno = 0;
> +		n = recv_timeout(sd_peer, &recv_buf, 1, MSG_OOB, IO_TIMEOUT_SEC);
> +		/* Ignore unsupported sk_msg error */
> +		if (n != 1 && errno != EOPNOTSUPP)
> +			FAIL_ERRNO("recv(OOB): retval=%zd", n);
> +	}
> +
>  	/* Ensure queues are empty */
>  	fail_recv("bpf.recv(sd_send)", sd_send, 0);
>  	if (sd_in != sd_send)
> @@ -192,6 +205,9 @@ static void handle_unsupported(int sd_send, int sd_peer, int sd_in, int sd_out,
>  	fail_recv("bpf.recv(sd_out)", sd_out, 0);
>  	if (sd_recv != sd_out)
>  		fail_recv("bpf.recv(sd_recv)", sd_recv, 0);
> +
> +	fail_recv("recv(sd_peer, OOB)", sd_peer, MSG_OOB);
> +	fail_recv("recv(sd_out, OOB)", sd_out, MSG_OOB);
>  }
>  
>  static void test_send_redir_recv(int sd_send, int send_flags, int sd_peer,

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

