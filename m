Return-Path: <linux-kernel+bounces-870470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05614C0AE3D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A516E349945
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2560235358;
	Sun, 26 Oct 2025 16:48:54 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597E2AEE1
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761497334; cv=none; b=hkeBpbCYGrGdF4dAaI00Kaq9EqBxzSaincNsAo8LjbBiGX/nS9LxF6Q27X1r5qSuS4Y8vxZu4Blt5tSjdA5BDjN+HRsiFZrysMbyFVVmnHO8diYQZBuECxx9irVqVg2QBaiskc32IyU4a7NXXtPcZD+E5jOqQc0LqwvC0/AlOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761497334; c=relaxed/simple;
	bh=JFn8LXF0w7jvY573lg691XCpspXS9XuA3/3kMAksIAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Svgl9QvwofDMVn3m12sQMhMZOCufzCuZUyS8tPBwa9TPTWd5c2nCtYYUL/v/7j7sRdEPB12dE2rI0yLdR0d0N1Upiy5tiLs4WUYEpDxZuSFu3eSdwycZGhN94TO/VZHDgmPSuSCq+bzGfbt1UZusu9axThgduedT5lTcvtZ+zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C8EDF58F94;
	Sun, 26 Oct 2025 16:48:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id AE47360009;
	Sun, 26 Oct 2025 16:48:43 +0000 (UTC)
Message-ID: <2362285823b62590148255214d53997ab128ea37.camel@perches.com>
Subject: Re: [PATCH 2/3] checkpatch: recognize __chkp_no_side_effects(_var)
 hint macro
From: Joe Perches <joe@perches.com>
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc: akpm@linuxfoundation.org, Andy Whitcroft <apw@canonical.com>, Dwaipayan
 Ray	 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Sun, 26 Oct 2025 09:48:42 -0700
In-Reply-To: <20251025211519.1616439-3-jim.cromie@gmail.com>
References: <20251025211519.1616439-1-jim.cromie@gmail.com>
	 <20251025211519.1616439-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 6ojbx3cq3bcezmzw11ducedr5jso54kn
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: AE47360009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18LqItspYu1JFbVEaAzvpyU5D9wnSjmKt0=
X-HE-Tag: 1761497323-292516
X-HE-Meta: U2FsdGVkX1/0xC3DigITSc5YRbEAF6RROkowhz0AWclvjYCWYROULnEGd8q5F5vRNdFlYmTfyDtMwRy9K7dLSXHLiwXmKYrSlhkdbE7Q1jLEVDHhQHiofdk+SKsbMmX8/B41TqwnlU7opftyHL0Eh7iIc2ctizYQV30aPbao27HwIFqjC+8wi7XJzq/rzkd+Ycu606/50w1Fn/Gc4Roct1PICNjzZURyNfplfITGD6crt+VgHSzmC68rMODoqGp5dhXCPYwYRUODX4j9brLlMQFE1j/ctiiUBrBr48oL/BGDlRjgqNq3X371O4KQAzCS

On Sat, 2025-10-25 at 15:15 -0600, Jim Cromie wrote:
> Teach checkpatch --strict to allow an author to suppress specific
> var-reuse complaints:

It seems to me that annotating source code to silence checkpatch
isn't a great idea.

If it is a great idea, maybe a general CHECKPATCH_ON/OFF(type)
mechanism might be better than specific controls.

