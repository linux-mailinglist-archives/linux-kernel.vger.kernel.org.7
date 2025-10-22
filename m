Return-Path: <linux-kernel+bounces-865926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F058DBFE581
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B52704F0804
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA9927E05A;
	Wed, 22 Oct 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbbn+Lry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFC4274B44;
	Wed, 22 Oct 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761169678; cv=none; b=LeQhBmMIbd2dodIHbzzwhU7lYfF4ly6I+7/XQYAV2Tq8m3Sm1EjWwsBurMHZdkiTp/wQGzUNY9MGef0Xweywyuz0fPMlauWuQVL6+ImDksx5o924HVMt/ph4qn6hIQ+l0zUSnhxaDmXd9pSLJkXBY5hrXNii/h3MqPtIlyrs5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761169678; c=relaxed/simple;
	bh=vkhJrSr91sdTyVWQzyMLObTRuuDmp5dmZhN6X37eijw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ujkIUSa/gAgMTCijXOy+4VfjHHbqDxca+gjMNPFCanV3MAfD9z8Augflmhq+C7gTLTla5e+aIljl36j9XvbSZ/YsabgP589Wq5iiw3f+mdfSTHtDqMKrQmqZW+BJCCKCkI20XGFV9Qsu98PkkZzk58C3CawX2lbqKDT2ElBskz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbbn+Lry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2B5C4CEF5;
	Wed, 22 Oct 2025 21:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761169678;
	bh=vkhJrSr91sdTyVWQzyMLObTRuuDmp5dmZhN6X37eijw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbbn+LryvouAsaUwhNBJ86ojThXBKDekKqVN0GL3SSRjk0gi8t3QcPkqBZkZAvtIC
	 0zIHY5gjrrvb9LAcWNPaXQYS5jhyosWUR6NVCfnDNHPB4NNJRLBectZnaMFF0avOGy
	 DzjB3gLkQ+3wwvoC3mLvYW9v2Fik+1bogwLxGjyvsJ0WZ2wi2bYUhPIA0rPObwyY8E
	 myR8LuHWjrx/lnrFCPFZ4QSg+zVtSd51G5HXA6d55SQKzaTANerA3JFlUYVxc1Ca+l
	 bIQxT2pF++9wGCwoqaQCbNFBUNAA00riXrHRfOjY0NAgEpbOLwvkfoCs0rHy0kDDqk
	 4a5JRdydEZnJA==
Date: Wed, 22 Oct 2025 11:47:56 -1000
Message-ID: <9c89f7de30ed5da565723f47ad5222b2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, peterz@infradead.org
Subject: Re: [PATCH v2] sched_ext: Fix SCX_KICK_WAIT reliability
In-Reply-To: <20251022205629.845930-1-tj@kernel.org>
References: <20251022205629.845930-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Tejun Heo (3):
>   sched_ext: Don't kick CPUs running higher classes
>   sched_ext: Fix SCX_KICK_WAIT to work reliably
>   sched_ext: Rename pnt_seq to kick_sync

Applied 1-3 to sched_ext/for-6.19.

Thanks.
--
tejun

