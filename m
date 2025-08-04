Return-Path: <linux-kernel+bounces-755762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF664B1AB78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99F1189F5F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197923815C;
	Mon,  4 Aug 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="K6492FbG"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA12E36ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350281; cv=none; b=hFUOvQ0I6HYf5xI49DFYvOUhRIvw9Xr3R9qE+BfehVuEbWSAPdYEXfzuRmk5iXtt6T1IIkTVu3s6qEiA0qS6Coc4e+WWmI2tHVVCeC9MbHYU4GovHPFYf16czjOkKugFk3Is2OvbSyPXMFeKBuhKn8xwKFAM0Gdue9HP80QOtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350281; c=relaxed/simple;
	bh=pmVOSEsQ731UTS6S95FjRYGHWC6/pxuAi8DA4aZT314=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KQzQZp/YTY0V2u0+OyMCMi/FtllJ3O5p29MzeWjQ5vifdPFnkE+cfbjq16Jn+P2gUkGlcEDd45M++Lmr1m323R/Fw8o25PwrftY3xKYFxnfI8ItPNf8zNq5WCLDbBQbY/swuy0HxW+mW89KoG87/Mq4j+CmLwimwfl+m9jJdXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=K6492FbG; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1754349636;
	bh=pmVOSEsQ731UTS6S95FjRYGHWC6/pxuAi8DA4aZT314=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K6492FbGGXJ2Sm+Rukrl58+yxjSnKWD7e94Y4RPWSsJdMHXRFjgYookZgShFyU0V8
	 1zZLXPPVCdWfWh6J93XbPnnvqLhS6DH7dZofph7+6f06wxaVfmYznmzEd9c7sIS0va
	 JZxvpBgx4zxssaMnAJSmitVneDrm2nsErDcYd+CI=
Received: by gentwo.org (Postfix, from userid 1003)
	id BC5104038E; Mon,  4 Aug 2025 16:20:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B82524010D;
	Mon,  4 Aug 2025 16:20:36 -0700 (PDT)
Date: Mon, 4 Aug 2025 16:20:36 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yang Shi <yang@os.amperecomputing.com>
cc: ryan.roberts@arm.com, will@kernel.org, catalin.marinas@arm.com, 
    akpm@linux-foundation.org, Miko.Lenczewski@arm.com, dev.jain@arm.com, 
    scott@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: cpufeature: add AmpereOne to BBML2 allow
 list
In-Reply-To: <20250724221216.1998696-3-yang@os.amperecomputing.com>
Message-ID: <a76994b0-88e4-da30-4524-c8450868763a@gentwo.org>
References: <20250724221216.1998696-1-yang@os.amperecomputing.com> <20250724221216.1998696-3-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Jul 2025, Yang Shi wrote:

> AmpereOne supports BBML2 without conflict abort, add to the allow list.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


