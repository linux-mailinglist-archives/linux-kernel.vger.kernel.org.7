Return-Path: <linux-kernel+bounces-842018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B9BB8C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 13:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84774E32CD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF6261B65;
	Sat,  4 Oct 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="zZmOicF6"
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1C245021
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759575810; cv=none; b=ZVHZepA8sOZK6QkrjR+duhUx2u29CQBIXdNuZrRNzHuz55PvXAHnmqN027mEo4mHnfCg7XfcKK7oM2KbAf5NL3hvTKjjxLKTJm/M6OkhpIhA2nql8yiuev0v7KVJPDC3O4bvtnSPFd9iLwX1vTAm3XaTGN0gRv/WlCXYyBygulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759575810; c=relaxed/simple;
	bh=zY4q+qOHQAiAM+gLWnanAbK2Ly668w0XvxnR9pXhisM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rDnM5UHCKsOE2EV5BlSiuHQBVkgcPQqrlOhm39OE4mP6HoPbTMtlgDEBd9l5nVGqrQ9brzDi/DZ0GCZtLEZ9pequBfXpBCFqEgdGD19bmJgIxdMhz3AcBdhN1tSkoALjrIBjh3AVOrYs3scIsEuSeNbgu/irOmaR1hoEEUkSbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=zZmOicF6; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id CA1B2CB1D4BC
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 13:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759575806;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=zY4q+qOHQAiAM+gLWnanAbK2Ly668w0XvxnR9pXhisM=;
	b=zZmOicF6jYbXh8vR2B+PpbmoIgsU60ilRmJ0bcITf4TL8cntGRX+iAaoxZElb7m+
	dXl/0BbGvHmuBFLQLjAFAvsV8nte01b52OFyLgTpviWFRN9rnESqMoxqqmgQ6MXEbSn
	7wJ0XzPxD7hyPsekRLsJhvLqB7bRutoyrOwti/HVrOi50ehZ8pTTgMv5rlUcQYiO+gZ
	tCF49e1yk5/sXmRaCwEiajYszDwAA9sml6IU6XT0MUseZP8m8iWZGwc/TkNxZFktfAP
	BsPXkoh7YBIenSwML35JEYd7oHw+HOlFajsX0wIMM+xNKu8SmXH6mC1ImthQzF6qS6M
	b641zMcpVw==
Date: Sat, 4 Oct 2025 13:03:26 +0200 (CEST)
From: craftfever@tutamail.com
To: Ntfs3 <ntfs3@lists.linux.dev>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Regressions <regressions@lists.linux.dev>
Cc: Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>
Message-ID: <Oait04j--F-9@tutamail.com>
In-Reply-To: <OaiQgS3--F-9@tutamail.com>
References: <OaiQgS3--F-9@tutamail.com>
Subject: Re: [Bug] Memory allocation errors and system crashing due to buggy
 disk cache/inode allocations by ntfs3 kernel module.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Oct 4, 2025, 11:55 by craftfever@tutamail.com:

> I'm expecting serious bug when writing large amount of files to NTFS hard drive, shortly after memory allocation errors and system crash occurs/ Firstly, I thought, than this is bug in linux kernel itself, somewhat disk cache allocation error, but when I tested same operations on ext4 drive or using NTFS-3G module, bug is not present.
>
To reproduce a bug, try cloning two big Git repositories to an external NTFS drive mounted with ntfs3 module.

