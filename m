Return-Path: <linux-kernel+bounces-830094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B048B98BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DFB19C6E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67827FD64;
	Wed, 24 Sep 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JG/yp/GG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD922D9EB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701017; cv=none; b=k1M3TE8jEwOaa1Gu4pwWBMfn+wWyLoo4KWANl0ndVAvHrqJVJEX+CaurgiATUrJA5SrXh/MjOO6puZRJWqbhuJgLeTAHt3M1up3Cau+O+tiuomJ/vRzs+yYUUzCrtRs2oDsLTfkc87DJQFVpsgRbWyNYvb2HS1H1l+xe4erhNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701017; c=relaxed/simple;
	bh=HBlE3n4ENo5oy/Jn7i6rgZx/aMKsQCZ4EPLPydCtjdw=;
	h=Message-ID:Date:From:To:Cc:Subject; b=CguWbMepkbkTdMCdkrUXzBugIaMSYrGgA+acORlh/w1EYtwDX9ENvXkjoDL+xyX5byeAwL+FrXRzzZZDsot+CjGhZdPeWKDTllqhO8Ha14gO5UKxGYUn9R4/Uw32JlgVy6WXIJqxMvGICy7siRwJRLOpwF0FBfUFsAbP1bd2xY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JG/yp/GG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HBlE3n4ENo5oy/Jn7i6rgZx/aMKsQCZ4EPLPydCtjdw=; b=JG/yp/GGDfkddbTrHgrN1HEQjn
	2C8T8kSz3AhZioNXaYUHry6aA7YHqNq3u8Fig5DQDL8zBJPA+nZGZQvBKK97bN+iNMd16wNVTULeV
	wL6ZEYZuFAKyP93TtWrWXSyOp5VJuIMuSTZwWwi3xBXKpP/xrESy+Z7LpAHLWwtE0aLMEo9FwGZ8s
	i4glWXwz+UIN15yerMJtOIVCyFCfWr9As9zj7EAOYMxC/NIXGrM9iKqt1w2xhUETfTNAx8M/Dtub8
	0/MItEtNlJ4CNlohgqPk8s010lQAKdKAn/JmpXTOlOZavt4ULHN8i23Y4sxfNr+/h5d6YuEjksO0i
	d5RKOQFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTN-00000008iAy-23Cl;
	Wed, 24 Sep 2025 08:03:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F09A530043D; Wed, 24 Sep 2025 10:03:32 +0200 (CEST)
Message-ID: <20250924075948.579302904@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 00/12] Various fixes and x86 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

Result of review of the base bits that were already merged, and x86 support.


