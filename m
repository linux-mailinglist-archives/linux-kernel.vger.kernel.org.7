Return-Path: <linux-kernel+bounces-749707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CEEB151E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C50B18A4796
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299E2989BA;
	Tue, 29 Jul 2025 17:12:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D5149C6F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809142; cv=none; b=b+yjN44UFqgdbirlcSq1u5MnxypIqb7jO0M2ViCUaTbUrvvq/TTatU0AvYxuwplZ19o/agNbuw2LjykyTlFhXI51fJTFAtjNoCHeIv1NunKMzGYQOY1poH0xzOpRJhsDVVNyTjaDDKWl9L9v9LP1SYMvc8tXrmoRfrGHbHjOMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809142; c=relaxed/simple;
	bh=2yHCYFZ60mNvydP9a+/zK+DtK+zkr3E3n754wAlQeOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpU6Aa3hu2vveinI4Ik1KDvMEco6o/lvndjzL/c0bPP98u/4yqN1kQIGnelK+LYw4b9A4a/MXpt8y31XhpdZ43HgOFEXwDm70BKOOLorJZ++w+fLqyj6MtCc3qerupeasNt/A/811RHhv2ygsEQypJLlnStr3NIdetFrh8ubQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7CAAFB6D6E;
	Tue, 29 Jul 2025 17:12:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7A3A120024;
	Tue, 29 Jul 2025 17:12:16 +0000 (UTC)
Date: Tue, 29 Jul 2025 13:12:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 0/5] tools/verification: Improvements to rv and rvgen
Message-ID: <20250729131215.20fa9bf2@batman.local.home>
In-Reply-To: <735d8530-f733-4973-8b0d-ac601d0a1799@redhat.com>
References: <20250723161240.194860-1-gmonaco@redhat.com>
	<20250724104011.7b4e11d9@batman.local.home>
	<735d8530-f733-4973-8b0d-ac601d0a1799@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ss3m3hyimg88md64c18rrpb7sh8ze917
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7A3A120024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ssiWHF6Ex+Zh/n0fXUT0OEg/AmtPlS3g=
X-HE-Tag: 1753809136-182708
X-HE-Meta: U2FsdGVkX19HiauCXqDEfJKVpY8Qzq3uSIVyx4hcekD5AXFPStBahqr2XCi/o6LK5XoC2D5ivAAE7PumgSX/mHqUFU6eWO76gCLMZSaUVTtT6+r3KstA2PR2gEMIK/AujVNVSyLaphP4tnmzKXG4R8ANz99KJpfJYPXdyE/yn4T/2tKqSHZeCRe7Pz7F6/Ob8Z9CjSREqOqLfOUmwSvXHj6op0w0jaCOKWsJpYBnrnEgsRwU2GuguZmIurpnKPVIjC9/23xymfoMVif+n5gZ2SXammNMlCAwPPa8oXlU1DDr+lNF4EH8ZQKvJgp7gLnxWrTZkxp8+5wBYtg5mU3lL00u+tJzn+Nu

On Thu, 24 Jul 2025 18:07:35 +0000 (UTC)
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Alright, but I guess going forward I'll try to keep changes separated anyway, if possible.
> 
> Right, 4 is problematic here, it should apply cleanly on next though, maybe I should have rebased on your tree instead..
> 
> So do I submit together 4,5 and the kernel ones? Or again all together?

If you haven't noticed, I already just took it ;-)

-- Steve

