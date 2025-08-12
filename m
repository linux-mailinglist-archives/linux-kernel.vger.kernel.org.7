Return-Path: <linux-kernel+bounces-765342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B6B22EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58327B30E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA72FD1CE;
	Tue, 12 Aug 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHWaBBSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE2F7475;
	Tue, 12 Aug 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019289; cv=none; b=Bt2LNC6fAVC85B/orS4W6dSCNWaD2Bcr2O/8nYPJlJoCKBHAsbEDSqG6YNBlFPdNZZxt42zfK+ZkFDbHs60r+1xXyUuN7qobVTmLKvnDlCgdtsSZlPsGTa1OXZ1vaxlF2La9kkVRJrAfUTrtqUZJyXeymGF/dF3hQZwZF3QVrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019289; c=relaxed/simple;
	bh=DF7fq4sugiWX44J4BGYSAH4q/ZkOHSYVkqcu0c2uu3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=qmUQi1Wuo5rzVcQgnDP2CuU/HXYAlWIyJFVWgN9X4ZWnfmKCJhKRTcEhKbax5LDZryQ6BVz/T52KntF0YeOR3szhdumOOJFyZRuOdKzS73cUiYrESnz43sxClikBD7Ro9IRXxDnZNe5Dd7CEe6KW7V7qPC0YgNtkWjxKHkbm9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHWaBBSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FB8C4CEF0;
	Tue, 12 Aug 2025 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019288;
	bh=DF7fq4sugiWX44J4BGYSAH4q/ZkOHSYVkqcu0c2uu3o=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=qHWaBBSkQcOoYSUnfMZFYdCKB422Pplu7AjQxhZY6pBIsJwhA2PGv2KKSkKp/OQCW
	 EBfO2vpWYRYFRLnTXkVZws2NbrEmHfjDazj0vr1v6BVAj/dDxXtEFvS3/6lb/GgqX+
	 VTT6LKlSQ2ktIgZhBlapHcUQVplF/wbtPC1uTb5ji1Vxagodlntg8ddbvMasNOAF8a
	 ElpgiL3cQJEC7ZHQRxKylyoccZGlb5CpPuHl2bHHjdEK4RAts7sdoMTjbsqJZv4D6I
	 WrMBE5KjxUkxSfSzBQXbPE9ZwpVjoEfyUpYKQjfMWkHnQhtNiAlkW1lBSxBFgpOI1n
	 C5WgUU3yNqCSA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 19:21:23 +0200
Message-Id: <DC0MEWPXV9NJ.3HQEPBFID0YD9@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Abhinav Ananthu" <abhinav.ogl@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: auxiliary: Use `c_` types from prelude instead of
References: <20250812075109.4099-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250812075109.4099-1-abhinav.ogl@gmail.com>

On Tue Aug 12, 2025 at 9:51 AM CEST, Abhinav Ananthu wrote:
> Update auxiliary FFI callback signatures to reference the `c_` types
> provided by the kernel prelude, rather than accessing them via
> `kernel::ffi::`.
>
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

This looks good now, I'll later on pick this one up.

One additional note, when sending updates on previous patches, please make =
sure
to increase the version number of the patch, see also [1].

Also, please add a note about what changes you made between versions below =
the
'---' line of the commit.

- Danilo

[1] https://docs.kernel.org/process/submitting-patches.html#subject-line

