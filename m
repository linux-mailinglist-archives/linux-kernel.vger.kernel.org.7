Return-Path: <linux-kernel+bounces-871249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF04C0CBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C34E5AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4B2E7BA0;
	Mon, 27 Oct 2025 09:45:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443321C9EA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558334; cv=none; b=D/aJRglkFR3Aq5pNTWU4Fwi9FU1eRItxaHx6gQWzGsi+cs0zOmx7ItP7iOlVmObj/cYLI2dgHknSPF1VBa2iYoGCMLwW/UOYzWa385+f/zC/mlxg0B5x1hsZcDWmfEwmnpNgqWipMqPaKnimmFlDMfSi0zS0LIvPxJ5SKM1C2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558334; c=relaxed/simple;
	bh=WpFPZRyZ2k5P6LqztYiKfPSYReSnAwG+2ckBOKTDE+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4KcGSY/WQzh4ch4ikMQAK8oQZPOFyrvZ7/05QAaN/ur0E3WAYAglVRbVfLWPS/swQAtGu4dElT+F+Eg6oYNWd2B6fzmM6fgrPpPbB4P89Y2JYPkzKbmjpc8FU8WckVx1+t7BvGkqAjteNnd47fs0p3UJ4BE+LTatwolxArotcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDB6C4CEF1;
	Mon, 27 Oct 2025 09:45:31 +0000 (UTC)
Date: Mon, 27 Oct 2025 09:45:28 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
Message-ID: <aP8_OFZaS_oh6_gp@arm.com>
References: <20251024013137.136926-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024013137.136926-1-anshuman.khandual@arm.com>

On Fri, Oct 24, 2025 at 02:31:37AM +0100, Anshuman Khandual wrote:
> Add some [pte|pmd]_mkwrite_novma() relevant tests.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

