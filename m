Return-Path: <linux-kernel+bounces-753965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9851DB18AD9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2A189B0D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CA199934;
	Sat,  2 Aug 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="esF5BTrn"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860CB672
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754114051; cv=none; b=JNNYuuugcJ/1T+L70G5Fj7UK++57DfunBMsytZZE8KkFPu2qX+aIhZtcTNccOQ6EYjJa2tqHdrSgcUpt8cbITqYXyZi5lTv87XWwXF1yC3iuvIPJufWwwyNB7KbBnD+9py/CUdbfDc0DpsYG9Qfs7nnz/OPhNkVD3cLGYZ64dvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754114051; c=relaxed/simple;
	bh=8HCiebAO0x+fC0M7JWwz0H2F6e70O9zU5b84g35COCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQcBrzT6XTTHkcx08wc+83RHW+EHmHXtObo6wfcUuOw7lX4XeOkgTTKZych8UFlHrg1T+kJQNKA9QJ+5BYvI2pe9sZ2JxH3seO2V+GSoUrtLkBEDPG+jKMqvi6IDNUBvzOop6ZGkOGf/2CA8yn7HwEKDvg+rCdHjYPhN8QgotqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=esF5BTrn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sjd6qusTmIgUFcLlIK8Zz932XIltqmChbiNN5UaIb2E=; b=esF5BTrnLhehEkIGLyKT70uE/v
	gQm4k++liq9CN3afZ3SJfP01VsyCvzUH5MkGfa0j0UZrrkLbZd2TsWZ5W0kO5kWQQkkHqaw0yW0y8
	VAAB0CO9CyNjdMvKGKzgU2EYA35YQ8zlhOxyCYgoafOgXWwS+Scj9TvMD6hGgGbL1+Q4Io189iaol
	chH+Fc6iv9VGXZuVUr33Dg4n/setne61Uw2kK0wmI9LSBauvI5aWteWn5o2trtvE1xk2uohzc1MH1
	+sXMTg8fZzFnRDXd+Pw4TTOx2uYLi3pazjshRsqGyX7Qq9Fs96CG4yjb05H1mRSLuUNy/5xNupwfe
	BTr12onA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ui5C1-00000005lLq-1YCj;
	Sat, 02 Aug 2025 05:54:05 +0000
Date: Sat, 2 Aug 2025 06:54:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYQ==?= =?utf-8?Q?l?= Mail]Re:
 [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802055405.GV222315@ZenIV>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802055252.GU222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802055252.GU222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 02, 2025 at 06:52:52AM +0100, Al Viro wrote:

> ... for asynchronous callbacks if that sort there is no such thing as the current
                                 of, even...
> process.  At all.  Using current, let alone looking for its PID, userns, etc. in
> such context is a bug.  Don't do it.  It's a bug in your module.

