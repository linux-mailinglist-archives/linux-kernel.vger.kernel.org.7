Return-Path: <linux-kernel+bounces-851279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57FBD602F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0473E4E2F34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB402D9ED5;
	Mon, 13 Oct 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="bfWo+rk0"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8ED25C80E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385265; cv=none; b=EcOOgnYAAxGiLdixiKN13/V1Xc2/5+pQb+Wm2pg7j4REK+sXKPTm36w9vAizeG2kb7BkUKcw0y+8FrLQsBrhwrBlj0jwMYNz3RO4tCFFAp/Y1L9Xkz8VjFEXLzAgk3gdYnAi9mYnkVKy4SuTecbz73C0rWAKOCc3W05lxqNHgyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385265; c=relaxed/simple;
	bh=sRPt6CGNIXWQXSpizcbH/gw/mGal/TsuE5oKon2pmbo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=q3E6vEMuzUG5i2+yROD62qcXFrFCIt0jLbXIhH9qs19W0OtFXfbP6p6RynWxaNuLas9Eeof+pNBdeW/RwElGVSVdAkb6TNoR0B1VleynA8bAE7Yt0ncKXBpnCDeSs8CvhP5Rv3XXvFl0Fdop2ez3ouNFLBxwqFSkygZ5X0AezCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=bfWo+rk0; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <46d26246-5bd5-43f7-b1a4-dc721f717413@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760385259; bh=sRPt6CGNIXWQXSpizcbH/gw/mGal/TsuE5oKon2pmbo=;
	h=Date:To:Cc:References:Subject:Reply-To:From:In-Reply-To:From;
	b=bfWo+rk0mHr5xdCG8lD0rslYPJsi5TliAFVrOOxjygYbpZTV8i1LiKB4DX46Lg9ih
	 +i70hDaf1qfqnRzsqIJcb9GRtMOtkIzyFd+zDb1ZO2nP4g3f545+tMHWjWBfgFf1sZ
	 kmhw70mXnKb9NuZFcLy773FCvV2IcQv2d5eIS7PkIECJNoU0lMOUZWjpJtWDJfkTuj
	 YYwMJA0mKeM65IC0ePYKqa9KRJRf/JzEn1t2nhtN9a2VuIKgxA6xC2EQtn1Ro36n0i
	 U8A/YRyygHIvW5yB7wfaxbD6pp3S7VJJW8aj8OkhNBzBlNLdPu2zuItRAFbJePu5VZ
	 ygpTBuNXYtqeQ==
Date: Mon, 13 Oct 2025 19:54:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: david@redhat.com
Cc: 423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com,
 akpm@linux-foundation.org, chengming.zhou@linux.dev, craftfever@murena.io,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, regressions@lists.linux.dev, xu.xin16@zte.com.cn
References: <80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com>
Subject: Re: [Regerssion] [KSM] KSM CPU overhead in 6.16+ kernel compared to
 <=6.15 versions ("folio_walk_start" kernel object overhead)
Reply-To: 80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <80b153cd-8bba-4bcd-9b56-3b2ad3f295e1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Unfortunately, yes I can reproduce it. And I thought that lockups does 
not happen anymore, but I was wrong, I booted today with 6.17.2 updated 
and KSM enabled and whole situation is back. But, it only happens, when 
scanning pages corresponding to a process with huge VM size, like 
Chromium with 1TB of virtual memory. The rest is alright. It's look 
like, that the folio_walk_start called with much higher frequency, than 
in 6.12-6.15 versions. in that version page scanning of huge VM size 
processes is pretty fast and flawless) Right now, when Chromium is 
running, I expecting constant 42% folio_walk_start and 15% 
ksm_scan_thread on 6.17.2 kernel (contrary to 1% folio_walk_start and 
even less ksm_scan_thread in 6.12-6.15). I must admin that whole system 
is not freezing, just Chromium with high CPU usage from ksmd and kernel.

Again, on <=6.15 it's completely oh, and looks like call freq on that 
functions is much more frequent on 6.16+.

