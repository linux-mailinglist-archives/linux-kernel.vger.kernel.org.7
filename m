Return-Path: <linux-kernel+bounces-725162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A04AFFB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF85A4E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9128BA86;
	Thu, 10 Jul 2025 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K+pXULBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88A17BA5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134317; cv=none; b=L7wFYSfzhY77TxpNd73fGewkECorF0X3kkDeFva5wZkeNGj0kwb4qqi8azG3D77PnpIfY2+2nzQkR53ZmsnlMaMPSmwXFiGpDeSRfDaTLkywITEZopNqFcf2/KDe6QH/g57EqztO6xXWSCIBjqLIQO79H1LuZHw2uFbEXnXiwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134317; c=relaxed/simple;
	bh=T4aOFk2HlYkW9Tx5IukuhkeaDB0XlSLFudFbAn0/wbo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EEoaJE/uN/pj39QjMhECSjQs6wcsItN7rE7C9XBSkoT6esRp3dJMa4lDAPUHkN4zyTmPnH9qoxFUid2ycTveKl8tqVIt5n18upYl+advWZI4ztI80YJGlPfSOlc1HZ66RT1r+XKOx6Uw/v4JHFiL0dptDHr8D8vs1EKG2tqByZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K+pXULBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C485AC4CEE3;
	Thu, 10 Jul 2025 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752134316;
	bh=T4aOFk2HlYkW9Tx5IukuhkeaDB0XlSLFudFbAn0/wbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+pXULBknDJf1alItbIBhTUryAu7HQG7VGCuVqDAVbE4HoFu0NzFPWI1aNoMimhKn
	 dQ29tZ0J3aKYQzF+jJDM8FS3cWEhkCaEBmBAGH5EWM9Ow49ZsulXqkOa+lJtkcmQid
	 sabIN8y6GtYK/2qnTrLH059fbULq7d1qcycX8gFg=
Date: Thu, 10 Jul 2025 00:58:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 willy@infradead.org, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing
 page-extents
Message-Id: <20250710005835.8819c30579e37b90d79f4c53@linux-foundation.org>
In-Reply-To: <20250710005926.1159009-13-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
	<20250710005926.1159009-13-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 17:59:24 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This is only available with !CONFIG_HIGHMEM because the intent is to
> use architecture support to clear contiguous extents in a single
> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
> which excludes any possibility of interspersing kmap()/kunmap().

I'm feeling dumb.  What does the use of a string instruction have to do
with kmap/kunmap?

