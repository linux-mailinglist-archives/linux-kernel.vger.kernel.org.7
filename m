Return-Path: <linux-kernel+bounces-893622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB0CC47FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700113BD738
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E88277C9A;
	Mon, 10 Nov 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Oe6dOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037D1C8FBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791336; cv=none; b=gVu6lLlRBmyxFQZbiP4NwvDyzCZdlkZbDliKVCQf+nGf2KBcKnkSv6WCAXnypKfI0vmu3d7T0niKROjkoqsCUN9dBU4KM6wCvLQ7Ckrsprydg7IjtTWRcIpi+j+d/j98kBg/L4yxh1aa3rrIVCSNoq9tcVioOWwfbIguc7jWB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791336; c=relaxed/simple;
	bh=AtJ3p/4dQIVzuyPyRHCEktUUudwRUbhR/srT3UfJ4wQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gCpgOoNmWmUPpzDFBmnYTFfenM41NhP0PydAk3fpEDIPRcR75+c579L6t0qHoJ5e75R1pxbAK6V3TXTjhb3rCKNMqyg7s7cjNs6ZohgDLuiOcUWHKCfebwX+ICm8u24IAtLjXeYp5rvf2IwCr6WtkH6hJZoDKSJvu41Pdq/Yeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Oe6dOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EB0C113D0;
	Mon, 10 Nov 2025 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762791335;
	bh=AtJ3p/4dQIVzuyPyRHCEktUUudwRUbhR/srT3UfJ4wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9Oe6dOLt8Or1O2gIpkpcwXhw97+DPYQm7cdKVWhtQPJ+/ehLDOExbdHqIaYrPlFu
	 gRKzT7gXD5Qu909RX6k11ivRqV83y9bCL/WBvxc06XRQFRBWmqjV4bYTUNoitn6W/t
	 ED5Cf5T2zBCYj+imksKzviJxYH9s8J/tm3cqf/NfkuSssAnZH/O9Ap6SZ4qzuQWva/
	 2mOM5MsK8cjKfT4t1/yqyqw9fW1OlmjjpqWx2agTZSPikuJEQhoR4xdko/H8Mnapye
	 fj0HC4yBnn+l7y/X9AMFrZHRjiOGWgnd8XwQHam6de43boQzQmC07yjUbuqgxPNQe2
	 cgURkAl423iSQ==
Date: Mon, 10 Nov 2025 06:15:34 -1000
Message-ID: <ed6a83ffcdfb7be2f6fb7438a576c77d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, lkml@gmail.com
Subject: Re: [PATCH] workqueue: Remove unused assert_rcu_or_wq_mutex_or_pool_mutex
In-Reply-To: <20251110012608.764-1-zhangjiao2@cmss.chinamobile.com>
References: <20251110012608.764-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Applied to wq/for-6.19.

Thanks.
--
tejun

