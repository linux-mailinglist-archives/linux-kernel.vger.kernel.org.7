Return-Path: <linux-kernel+bounces-891475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EDBC42BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE29A4E3886
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2102550CC;
	Sat,  8 Nov 2025 11:20:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D9A937
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600837; cv=none; b=dM6/jqdFf5u01zc70puQr264MnVEOgyQYXYvNIOBaN6dJoEUXSnMPdoCBtdmR1sZZmRqSBMA3cTklMSfDg4BmUk1BOpqUsKtgrSIRLhgSV6eA2TBXtp0G+4LrAs9HQvddOV2GstKf8geVMXzhQJq5jX2aF+37PndtAqk+iFWZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600837; c=relaxed/simple;
	bh=LzGDqy90kyLrU0YnNZy0sotPQtZDQuSJSoD37aZLUL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hJg00rQhm3ofDVqqUQSZlKbiYQPE6t5EfU93MVvxr0P7jB8p2naYnlMxDFhJXfK4pBr7dumhxhTcjUOjkUPBRSnFeHW9nBNWA5dIffy7vZ3DoG+AlEi7txMDx0m8lCex9AdV+csoPH6COfuKT2NVRBfXkM8ENttuL3EilkY0I+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d3YHH1lmCz9sS7;
	Sat,  8 Nov 2025 12:14:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wykipwaqZfoa; Sat,  8 Nov 2025 12:14:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d3YHH0rPtz9sRy;
	Sat,  8 Nov 2025 12:14:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AEC48B765;
	Sat,  8 Nov 2025 12:14:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id R_iuyd3THbw8; Sat,  8 Nov 2025 12:14:50 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BD968B764;
	Sat,  8 Nov 2025 12:14:50 +0100 (CET)
Message-ID: <a88e1546-1530-4326-b0ee-dc4e50d0343f@csgroup.eu>
Date: Sat, 8 Nov 2025 12:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <2025110513-manliness-repayment-d005@gregkh>
 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
 <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Again,

Le 08/11/2025 à 11:05, Christophe Leroy a écrit :
> Hi Alexander,
> 
> Now I'm trying to understand why the problem surfaced with commit 
> 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
> 

The reason why it was not a problem before was that the transfer was 
done into of->prealloc_buf (fs/kernfs/file.c) which is a kmalloc() with 
size (PAGE_SIZE + 1).

Following the rework of at25 it now goes into the bounce buffer which is 
allocated with the exact size of the transfer.

Why do we need an intermediate bounce buffer now, why can't 
of->prealloc_buf be used directly as before ?

Christophe

