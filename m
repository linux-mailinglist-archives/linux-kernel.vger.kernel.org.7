Return-Path: <linux-kernel+bounces-894337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3BC49C71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0964A3AD09B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61A3019B5;
	Mon, 10 Nov 2025 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU4aKmJm"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B1257AD1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817848; cv=none; b=RWcEpIrfLoIWz3hhMLiAT5pFVw/sl9RN0obJdoUv6pHuGqstxIVZn1F0EaEFvY7tJOsH3rlJIIiecx27OIaX3nuU77tM6QLAOqt8C507cyP3lQ5b5BCxjSgpOMFq6T8A8c1LJ//jcP0zT2rKXZcbCi7oo1G7iiiW+EmPXajpTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817848; c=relaxed/simple;
	bh=rXO4cV7y/7KRb7+PNQISNcMuBYWSEWB/8HSqi1ED97Q=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KmyRPJKxcPWoa0MPS27YJiJO6kdVDHvJ7c7ixlWsNsX47VyX/MaM/MlPwOTLKjaQVEQl9YWdXpzrcfnx4buu//bhY+pmBWnhBSTiyaz5fZfZ4wf/B7WdhoLXG1rWVLqPS7Gi9N6h9y4iaqrGN1Odr0hn9AqNJw2zCFUq9CdFyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU4aKmJm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1646663b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817846; x=1763422646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sONTki0cwOLfaZkpfYHcU55+KIViW3n5GsMd/O6clDo=;
        b=iU4aKmJmPQFFu6HuGPy+dniFZzsRzu93Dztck37kZux+NCANth5dS/vn5Kf7tl1cs8
         8eDdYdJ7kqKRx5Woe7IEOo5m+4KdS/EQ6G9g/wVpwJF/altfX5qGUBq3hYXA1NXgDAdA
         kikT3CzIf85oY4pC/aOdq9t2PL2SwtLaQE5wQnqcMxJ1+c1TlL1ChasGIUmjMtZTXbMi
         G0KyCDdObgOvygJQge/6ovktyRI+joN0I7ZblWsQCk+tft329gQBzPU7TedOe3PERrk1
         MONBz4NxHCjuqQTIWdHtiHWF+KZDJ10mQBFn5YED7t+I4sFzPTziFLSPPiGq3Xw2Qwxn
         43PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817846; x=1763422646;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sONTki0cwOLfaZkpfYHcU55+KIViW3n5GsMd/O6clDo=;
        b=S/QvDEVAnluAIj8TAYXsithDK8hH2CjgYGIO/guCspDg4dC/HM1M54BkA+cSGmWLFr
         1KMQvOwDzvyGPlPjIA20V5SkFZ0IQyItNBJHsLCidTKGYdtreK+7bkaJyTcjU70mro+G
         URCv/XAGyBiPh8xd2SFiWwYTMJ6MnkVKCEZodKBB/16dkNEbx0vrfe4tQU0JAHXKpbCY
         1DfLdAldM1okE6AgBCfwfxdvtN4JXlyY20vnPBHmw2fM13Co2xhYSOMob7y7/quHd9GO
         m2L1bAn75K9nHYn+gpv0RaORdNpcJ6xJXofKQVlfj0/aChAbSRMIQJyQdK7ogqptZ9+s
         mnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsa7Lm4Fz4oa+fc2egoCtS90zwAYYjZHpy6C/OlqehjfE0rnwQ64QwOnbWNGRb8YraU9InPCCcujLfdag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TbwhhLCpQDR4erGOPewK2+NJc0hZ8BOLMgzrlYRL0MZhcFJc
	+iVmgaxp/ns7iXQOriuKgxQuk8BtzsSN+m0Qp2T5vw43OGP3mB6naoQe
X-Gm-Gg: ASbGncs8eTxh7B40rjKifpoT99ZwJcCaQxzYWbl9+wt4o8C9+T8gt43aC+fMqoiksTz
	JfzjXy0m2x/acHPnu8LJFbdBnGBszhl6uRlYXdNWWqGUC2S+aDRZ6aiFsjJrIuimZ065ch3tkp8
	qz2bEa2zt1iqRVMRfWlRQAfcZz8sMErhk/ePaKc145Ru4fcRzhlnYys000qkPIORu8DY1GVN3CU
	2BSlsUbIRaPGW/YTfB4tmrTbby9LgV+x+gv0O/jPPwtAZaCYBEz61OivfEF2KzLKFqf4gY65zJ1
	4JUdqL1HU4IR46CKcUyYu13UunJyUam+VEkTeKxzQ11z2pBxsRB2y8fK6aZJpxzLC+Uup7P1+H3
	Y+GjiZvU/W0jN+YT+9BgMOe4uH91Yb3qXN6+R/0dVUfsd2Bczp/gkeYu4vTvsji0wUj+D1vcdGN
	a2b2WJ9H5It6f8B59clAzEF6532cM93deuk+TPeNdNhl+IeBU8iNHPmE10m65r2EY7
X-Google-Smtp-Source: AGHT+IHk0TS6U1teQSHT2W5LJ/UoVkLAhqZnFd416dWAUwj/XxNWZoZkE3GEbfX7u/ERSkanItOk1A==
X-Received: by 2002:a05:6a21:6da0:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-353a3355034mr14081651637.34.1762817846261;
        Mon, 10 Nov 2025 15:37:26 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm14277596a12.21.2025.11.10.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:37:25 -0800 (PST)
Date: Tue, 11 Nov 2025 08:37:20 +0900 (JST)
Message-Id: <20251111.083720.572544715756974945.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 3/3] rust: net: phy: follow usual comment conventions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-3-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
	<20251110122223.1677654-3-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:23 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> Examples should aim to follow the usual conventions, which makes
> documentation more consistent with code and itself, and it should also
> help newcomers learn them more easily.
> 
> Thus change the comments to follow them.
> 
> Link: https://docs.kernel.org/rust/coding-guidelines.html#comments
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/net/phy/reg.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

