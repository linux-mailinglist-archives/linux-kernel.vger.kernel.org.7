Return-Path: <linux-kernel+bounces-844471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEDBC2019
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F44F6976
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BB2E6CDA;
	Tue,  7 Oct 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkuOSpol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AD2E6CC5;
	Tue,  7 Oct 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852682; cv=none; b=s+7rkxK4iPelau5SbhIZcyn0V8Ha27n6MLDZwhVgTP2eyv/V21Quf09zUY5qLz+ffkrmGHxMxfqcbbo/ZmGD2c7fc8n3fu9OyD3xQ/X8DFpUUh1R/iJjrDUqxZHcPMIS2mn+x+ZMud8bb9X/GAfHlDSAMbbVewYgqdI23+iRdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852682; c=relaxed/simple;
	bh=tUkwYE+WYXPDcA/1EEWqrHvj+3U8dasHlajHmfxDfAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyy6h/3l3OKwVvRFSI491DsVKNCfGZ2SD9q1ZFy8mmwZmymdh+w9wo888O/i6zw8RPS3RNwOkkM7Rpx3rngeRRa6/YWYfEDWrmjOa4DqPgY9fIyo1KRjwkvNBWjQ6phZ0whRycIlvKbXcw3vXf+we/2oVksK68BjgO5b2ljN0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkuOSpol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13047C4CEF1;
	Tue,  7 Oct 2025 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759852682;
	bh=tUkwYE+WYXPDcA/1EEWqrHvj+3U8dasHlajHmfxDfAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkuOSpolfQ4JsOEjbh+GBVjoOlAkC1xvNpzNOkYpIhlveaeSbVDhOJNaY0m4/TMGh
	 aeBhhCqopBG5UgCDJaU/jn1A/5IvPmk5suuHdQJoFNmaoJ++flz+wnQ2SchAh/E9/4
	 kc9H6Tif+O+FLX/ETZhsaqGcVlvfsw1XK0sApt6c=
Date: Tue, 7 Oct 2025 11:58:01 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/docs: sphinx-build-wrapper: -q is a boolean, not
 an integer
Message-ID: <20251007-thankful-badger-of-fame-0bbc65@lemur>
References: <cafa10cddce3e5342a66c73f3f51a17fb6c7f5d3.1759851791.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cafa10cddce3e5342a66c73f3f51a17fb6c7f5d3.1759851791.git.mchehab+huawei@kernel.org>

On Tue, Oct 07, 2025 at 05:43:12PM +0200, Mauro Carvalho Chehab wrote:
> As reported by Konstantin, sphinx-build -q is a boolean, not an integer.
> 
> Fix the code.
> 
> Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

