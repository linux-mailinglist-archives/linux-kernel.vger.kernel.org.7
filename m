Return-Path: <linux-kernel+bounces-776815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3350B2D1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA06524873
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1327F724;
	Wed, 20 Aug 2025 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="aSlIru3f"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24027CB35;
	Wed, 20 Aug 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755655522; cv=none; b=NKQIbHEOAxaV9fXjquytXYIiQNRATGltACCZhVE3tkY8ir0Rzg9v1IZn6YzpAvot15zVZ8EylxXE32ZfgiZRl9cKt/vFCWk7fMhU7LwoiOcvgPQ42cbcPY8SuF/b9KpxMsOxymuO9DgsoKMaqp1p/YQQYiY5hClEU12rNZuxY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755655522; c=relaxed/simple;
	bh=X9NTX1SzBwgkZdilljkAHG6X9Xk/OANUE6ryZG11rCc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OlblxYef6cAfjJZK9slKEJmGxO5KRFDsF3BfLZnIXwhd9UoO31jZAQyJacVTYRbef3Ri6+YDDzIv9iqie204OaCnCTgUP8s26+VJmSuBfnsuH9+VEsoYmlREXnv1R8WgNNJ1G0v40S1NPgE/jLd/g6MzYF8EzOygSn0D6eLoHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=aSlIru3f; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cUUe9dsY9MAIPqES7FFoDEA5qENhhjh9/kZ9Y8+L7+o=; b=aSlIru3fW1j+J8J3bjg4SlMHAI
	MjTEyeuCR8Brk/mXk0QLUVIPHSnnFqxxsZyIGDNnFqt1pXsmgGSjhPbUtqgdOGDhLViRkINT0Q2Ff
	EvMDL3qTIY9ffqy2lqWONTBuhgjHIWgC0vOK5CFZtHvSkgXxgHKd2PXQAFwdUlSrszi619JcA7rgl
	64AeW5bzkz4O9+RCc5KXzM8CgP2gaYTShlflxww+fJ4sTI47psbeXWP5WIPvmCHBowVkVyycDyUXl
	bneFLsRsg73jo8xANwvZzWheSF3NOd8ajyAGFw0KVZF0mXpFJ671KA/82XDlAPHQTiGweZwRR6Don
	ntb8YA0A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uoXwo-00FgHU-1a;
	Wed, 20 Aug 2025 10:05:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 10:05:02 +0800
Date: Wed, 20 Aug 2025 10:05:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Masami Hiramatsu  , Google" <mhiramat@kernel.org>
Cc: olsajiri@gmail.com, menglong8.dong@gmail.com, mhiramat@kernel.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com, revest@chromium.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] fprobe: use rhltable for fprobe_ip_table
Message-ID: <aKUtTpAYaMdNgj2a@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819111111.40f443fd7faae8e92f93beaf@kernel.org>
X-Newsgroups: apana.lists.os.linux.kernel

Masami Hiramatsu  , Google <mhiramat@kernel.org> wrote:
>
> Good catch! Hmm, previously we guaranteed that the find_first_fprobe_node()
> must be called under rcu read locked or fprobe_mutex locked, so that the
> node list should not be changed. But according to the comment of
> rhltable_lookup(), we need to lock the rcu_read_lock() around that.

Just as is the case for RCU in general, rcu read locks are unnecessary
for rhashtable if you already hold the write-side locks.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

