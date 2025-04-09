Return-Path: <linux-kernel+bounces-596758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755AEA8304F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B01B64BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E01E47B0;
	Wed,  9 Apr 2025 19:20:09 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE4143748
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226408; cv=none; b=C2t9YkueEQ4vrU8dPz3whe26OLzX+FrTylZF4yLH708L88OXB8MYkiyQwvwjkHuxgv/Cp94nntXGOWXeonUv3PxwMAn9/0mk8IoaYcHZB6SBgQF6hEPw1TeEypH8lFDDjnH7NYRQ/IYzyvQACyxP8e0CvPQCsxNGVbPm25tCIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226408; c=relaxed/simple;
	bh=hqBenjXXlI75jn7jnQ3YgqTeoaylHgAyHGnBJ3kJAUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ7qyIvP6mX75yJyDlhpSpvioEnG2pyxPcEQVINSiRY4YS4V016/GpwaTN64ykLcWk1hckDVC0zH3QaVOzI7zIov3F+qPNP/QsyI6xO+z0iWzcG/Il+GoszFGduTAsSWgVim7FiuLO/mXCnLRn+37V6JxXdXu/DSTDg892tbMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 539JJuDq032077;
	Wed, 9 Apr 2025 21:19:56 +0200
Date: Wed, 9 Apr 2025 21:19:56 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc/types.h: fix mismatched parenthesis in
 minor()
Message-ID: <20250409191956.GA32062@1wt.eu>
References: <20250409191436.75658-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409191436.75658-1-jemmywong512@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Apr 10, 2025 at 03:14:36AM +0800, Jemmy Wong wrote:
> Fix an imbalance where opening parentheses exceed closing ones.
> 
> Signed-off-by: Jemmy Wong <Jemmywong512@gmail.com>

Acked-by: Willy Tarreau <w@1wt.eu>
and thank you as well Jeremy for fixing this one!

willy

