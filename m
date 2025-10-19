Return-Path: <linux-kernel+bounces-859848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D58BEEBF4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18653BC8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256FA202960;
	Sun, 19 Oct 2025 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMVoWoFp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674861E50E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904886; cv=none; b=N5gV6CBAU0DTzPxLjMziMOXjl4Ec2HddwjsasDLPaK82ep9gCKh0byuRIyBGiOQiZaVb49OKwKib2CcAQXIVDpMmEqvSxTLuuidfP0TGH5RGpaOufsTa3fs0GYTQHO1lM/IrWuvMe7Xg4asBWUPrbZAvkF2tSt/AeV8W0vigvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904886; c=relaxed/simple;
	bh=Smi3JGM7i6MLP8+zjjFBRReqt3xd8cOsh+gh2lbqjeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJt/eYuc0yO+fHxm/OGwpe+f3eIOpuS1bjb90VPEF5IgMWuUHAExRP9KFzLyXyNhaYtE3rMjKk2eZhauCcB81jFFW7hnk6dNz71olX9sklMK3jWu27zrDUPqTDGOv5v65zUYkHXKwi7vP1+zVmbezqquMK+DLNPoUaAFbUtTYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OMVoWoFp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KQE2WMICXol8M7tcsnsAvEN3DKCYGmwZMsLRsgncwyY=; b=OMVoWoFpW/R8ekxshETeb2sT/V
	RsAxgDDDV0SiymSoaeihOaQQG8eGnDWqr9E7fxZ8gK2qFk/wuGAPkURSImtaLkx9+IPxVuLnwa4Hx
	jSO4M+MhzQcLKdTwzmj66CWbnvrXbmSWA8G6MPJaYTSYNLpdzSZE8fHFjyEjGUJIFfKmSFQ2YB9Zf
	6dUvw/lOoCl5r4pm8/3GcX+lKKj6KzHRNVUgoJ/Am0b90aRY9GPaJ6peTQiqJS0nlLWYpopHT9lMX
	j68+JvC02RRijOvzq2BbeUk+bu0NutbX7k7bXVtRbApwNm9/L0zuBAWxTnyCZJ1r2xCHellOSpYj6
	nmsyfNZA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAZnV-00000003E9q-12RS;
	Sun, 19 Oct 2025 20:14:33 +0000
Date: Sun, 19 Oct 2025 21:14:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: markus.elfring@web.de, Liam.Howlett@oracle.com, aliceryhl@google.com,
	andrewjballance@gmail.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: Fix potential NULL pointer dereference if
 mas_pop_node() fails
Message-ID: <aPVGqRKFcI1SjZdk@casper.infradead.org>
References: <9092f8af-72d9-472e-8d5c-f950c8ce782d@web.de>
 <20251019114916.1618642-1-hehuiwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019114916.1618642-1-hehuiwen@kylinos.cn>

On Sun, Oct 19, 2025 at 07:49:16PM +0800, Huiwen He wrote:
> Hi Markus,
> 
> Thanks for your suggestion.
> The commit description could be improved to better follow the imperative style.
> I'll update it in the later version (maybe v2). 

Do not send a v2 until somebody has a substantive comment.  I suspect
that what you are doing here is wrong, but I lack the understanding to
explain why it is wrong.

