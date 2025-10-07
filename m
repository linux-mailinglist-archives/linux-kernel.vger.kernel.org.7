Return-Path: <linux-kernel+bounces-844779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AEBC2C07
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8953E1A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA30247295;
	Tue,  7 Oct 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fMKH5vkd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AD28E9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872687; cv=none; b=d8f8cH4cCc+P3h2rgdkxTUMHNq6p19Kwzq/IOTSzaV75x1MJ6NFNERr4GF/zBXmo3z7JIud8IPS6JX7Vw3c2Rt6F6iseqeP4HZsIasyehcVPMAXLmGxMb1J9vIOZ6jQ8eN+FpV16Xfiix53SU8/U0nUDAKJBPmfin34GftrG6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872687; c=relaxed/simple;
	bh=OcA2rmW9ILaz7YK3rji/wcS3ixoqSNZBjA9FWLhRmfE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hdNHwaVmSeqfngc3CBqJC36I7uqnM4EIRVWHiTzYYCKKbsXw4ikEY65WeB3U9zyHbCkaObQyXYgtcckcGYY65Sfj6Ar900DiafX115513W19NUgPJorOutqbh/2zQgD2L3BbLodZguhbpeLSCltawXjdtmjbJY4vqVqU8KivnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fMKH5vkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E6C4CEF1;
	Tue,  7 Oct 2025 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759872687;
	bh=OcA2rmW9ILaz7YK3rji/wcS3ixoqSNZBjA9FWLhRmfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fMKH5vkd62MjcQveuUSO/Qm0wH1HnevbRZA3K5NxeKcaOzmJrfibwFugl2Sln/sgr
	 UEmsTTe8Hch2qFnQue4qQ+QfkA1qHD0DbrsiTbW3CVfhmfW5YlhzCHuK0E8vboAGE6
	 oOmgRanNGYvyQO1cL0YVs18r166igYmoHW6Th2pY=
Date: Tue, 7 Oct 2025 14:31:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, Baoquan He
 <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] __vmalloc()/kvmalloc() and no-block
 support(v4)
Message-Id: <20251007143126.451f73cae2d3d7f5a36e4229@linux-foundation.org>
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 14:20:25 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> This is v4. It is based on the next-20250929 branch. I am pretty done
> with it, if no objections, appreciate if it is taken.
> 
> https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
> https://lkml.org/lkml/2025/8/7/332
> https://lore.kernel.org/all/20251001192647.195204-1-urezki@gmail.com/

It would be nice (and conventional) to have a [0/N]
introduction/overview, please.  I went back through the previous
iterations and could have kind of used
https://lkml.org/lkml/2025/8/7/332, but that doesn't look very
applicable.


