Return-Path: <linux-kernel+bounces-834907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F9BA5CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042F63B4CED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9615855E;
	Sat, 27 Sep 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="Z1kreTyE"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6934317D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966366; cv=none; b=rgOsTOeRAO1m/1p14yBRPwf3oIRqS6rPtvl4al1GNfwigcoa/Y1YH9FPNlqrn0+MHK8ZuDx4joO/JjEoCZb9tUb8XvzKWYwOEl2b/JXs4yloZNwlO2kEpYV8kfWW1AO6y5GruQYIaCppAz19K62z/hVpQkvkwWplB49VH3IkKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966366; c=relaxed/simple;
	bh=Klfz3QjE82Q6MtSss0BoYpOUYoAQQIccZi9hwM5G+tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf9GIOrZAo8wU22wefunWaoKJRYm/IbhXDFG25fgyAN5Wlf8P+Ntj7Pu4WgDSeddL+nVXGGK4CaMP5hEp+w8jsNK1BDtv/EVqy1hV3SdxTHHEPGGG7bJxbscLApZcqPONs3QI/jjbMbZOMjuEEPbNNlk1TMubCjYwm3Ry4NH/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=Z1kreTyE; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758966355; bh=hBhm4GfyiB3DzQ2eNjSMT/AL29gWQrnBfvecAioJok4=;
	h=From:Message-ID:From;
	b=Z1kreTyEPfDzzfC1CbY9sEK6VmvEIKsEQhidRPuYbFQ+1PO2WikLUTl6X1eufdsFQ
	 rIpdHNIfvqINGS4OkcSOt8QCjwS7d/v6pkeOXYQjwO36dHNPcF9SQ+/NK4xp7NctNM
	 4X2ZWFF0DRHQxmVGtmHztuU7X0N45vOgHBBMO3p4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 5AA0CC06AB;
	Sat, 27 Sep 2025 11:45:55 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58R9jsLH025142;
	Sat, 27 Sep 2025 11:45:54 +0200
Date: Sat, 27 Sep 2025 11:45:54 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: handle NULL wstatus arugment to waitpid()
Message-ID: <20250927094554.GA25134@1wt.eu>
References: <20250926-nolibc-waitpid-nullable-v1-1-4e90500f6ffa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926-nolibc-waitpid-nullable-v1-1-4e90500f6ffa@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 26, 2025 at 04:26:58PM +0200, Thomas Weiﬂschuh wrote:
> wstatus is allowed to be NULL. Avoid a segmentation fault in this case.
> 
> Fixes: 0c89abf5ab3f ("tools/nolibc: implement waitpid() in terms of waitid()")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Good catch Thomas!

Acked-by: Willy Tarreau <w@1wt.eu>
Willy

