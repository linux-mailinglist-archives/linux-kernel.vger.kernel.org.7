Return-Path: <linux-kernel+bounces-749358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031BCB14D58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A897A3B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138F28FABA;
	Tue, 29 Jul 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ1JjI8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42428F92E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790601; cv=none; b=K4tARdYlj1ScX3KSOPKljUj7jblRprFVi6eODk5gfZaGb3ci4jb5aOcA1dTQR/9jnLnfPQFoupP3i21JXeGa/5nMHGDiPtBH3Ig2x7h1v64rDNm76aq10StZs8vu7TfzOWIQkt6S1sZuxfWV4kFW0TyZCN3bTG3yHT4UVJND5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790601; c=relaxed/simple;
	bh=dGmwdQ2RAXzElIWAcl/J8c2TPL2ig66+4xXEYHIlNhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3yTZuecy3CfHZ9Kp/tjNHv68dt9ohRor3iJL12T4Lke0ZzBbLmPyla6K2xxNaM5w47SKlrW/f0+LAwyyFrQF7rvq2eEWyaz+fJXZ9WfP1Rspt2ngHzVV72maFV3VxshIKyCLhWiIf9Lf4mnhWfEoeqyyHUuLlxV55Uc21BYeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ1JjI8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E3AC4CEF6;
	Tue, 29 Jul 2025 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753790601;
	bh=dGmwdQ2RAXzElIWAcl/J8c2TPL2ig66+4xXEYHIlNhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DZ1JjI8WmeITKts7XnOKtUl8Q5KMDR3j8SOkQHSi8jmXZP668WCmsK1UFZ5TVy28D
	 fDk0P5GCHq67sgEuJvyQGAEHaoIpTBke01yc4S1kmrryGtsjEYbViiPrXaUUMuh6v/
	 nAf8CARWtOuus23Ys4zESD/zBdIa8YgSKSl0+12lyvRebvwB+1GK/Mcsp2u7i9yzeE
	 rS3Mdizm6jkXZt85Gvl3KraoidQ1Qoix3GXFtmBkpDRYwONoH0wvwUOjbquWggiYxd
	 YzqbnIwdMsDpcKljJO9cqYEsSMpuFF16cQbvDWwPY3qyGuzLfShHh5CspMidnL51n+
	 5fIPQSJcign5Q==
Message-ID: <eec96998-fefe-4e60-96f2-549e349a46c7@kernel.org>
Date: Tue, 29 Jul 2025 14:03:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maple Tree Work
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc: maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peng Zhang <zhangpeng.00@bytedance.com>, Alice Ryhl <aliceryhl@google.com>
References: <20230707163815.ns4kdz7iut5octjv@revolver>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20230707163815.ns4kdz7iut5octjv@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Cc: Alice)

On 7/7/23 6:38 PM, Liam R. Howlett wrote:

> Larger Features:
>   - 64 bit stores on 32 bit arch
>   	A number of users want to use the maple tree, but cannot because
> 	they need a storage medium that supports 64 bit stores on 32 bit
> 	arch.

Has there been more thoughts (or even progress) on this? Managing GPU virtual
address spaces is still an interesting candidate for this, as they may be larger
than 32 bit even on 32 bit architectures.

- Danilo

