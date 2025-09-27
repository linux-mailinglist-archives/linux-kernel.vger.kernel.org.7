Return-Path: <linux-kernel+bounces-834950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB6BBA5E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0781B24B23
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515EE2BE631;
	Sat, 27 Sep 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0VQs3Tq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B4C8CE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972799; cv=none; b=cxuYDqQS2jQ5cEWvoSkYC2HjpeVsOB3LNpMZPJDTP3/bBcNn+q5CrH8siyCq8EwJO1Xvu2bmcsheJ60zyBOie9kwSsBa03El4ncBlIjSCkIYHVkhXndDfNdd7hfbwE+mQAwne6LZyuADhPlceNJsu4p9iuxZMCKRSks8zSTv/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972799; c=relaxed/simple;
	bh=ghBoMXoa3JZf3eoSdiItFbKEbCUCknh+MgBwj47EKds=;
	h=Message-ID:Date:From:To:Cc:Subject; b=L8qbxTp4j77e9pj2zPStFHeu1BNJkEg+qRpbVYhpv2T6vMcqHA81t+2OgNx2FDMmBLLlCC0WAJscwoV6y2HdbNZKQ7Zl6VUNJ0K1dTgFzvMQpHfMcuEjbwfls2qTcekMwrizMcIKUL16evd/OvK7hHxTnm6AUbPHZlKYZApl6Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0VQs3Tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346AC4CEE7;
	Sat, 27 Sep 2025 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758972799;
	bh=ghBoMXoa3JZf3eoSdiItFbKEbCUCknh+MgBwj47EKds=;
	h=Date:From:To:Cc:Subject:From;
	b=d0VQs3TqCyX3tSyZbnRzwTfpHQQL+5wiklNyWrlQWQHKQRfa5GkUwcXHOYXCqS4lO
	 IcGppKbXcE5upD2Wtu+3Geol8Z2FXf8tyILGFQm4+wV6DlSNAtNsPVEPJ+OWjSqGL3
	 dYSaulVEH1S767o9eFWYYgrE/HeKHr5pNpJA2fJggW3SRBcDgqaXTMh5GMVh59lhRu
	 BVy9ciQPQX2yvN2B+gCczSmrM1v6WXUs2ia8tOSjd8EDxGpvO75QwnEjyQqv9J8AXs
	 B/3sxaRAmcmjmcsfKizbdYvzQKBjZWu0MqiPpyJ9zOFE3nT/4s9lU+HxbJ3tPZm17F
	 saUK9u/MNhopQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2TCR-0000000D4MX-3HqN;
	Sat, 27 Sep 2025 07:34:47 -0400
Message-ID: <20250927113418.080268096@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 27 Sep 2025 07:34:18 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-linus][PATCH 0/2] rtla: Fixes for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Two fixes for rtla in v6.17:

- Fix a buffer overflow in actions_parse()

  The "trigger_c" variable did not account for the nul byte when
  determining its size.

- Fix a compare that had the values reversed

  actions_destroy() is to reallocate when len is greater than the current size,
  but the compare was testing if size is greater than the new length.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
tools/fixes

Head SHA1: 2227f273b7dc25a791ae6b152550098aa6934b2f


Ivan Pravdin (1):
      rtla: Fix buffer overflow in actions_parse

Wander Lairson Costa (1):
      rtla/actions: Fix condition for buffer reallocation

----
 tools/tracing/rtla/src/actions.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

