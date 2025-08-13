Return-Path: <linux-kernel+bounces-767687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C6B257AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146296249A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DD2F2918;
	Wed, 13 Aug 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HkUDrLBL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52B4C81;
	Wed, 13 Aug 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128565; cv=none; b=HM+Ietpb4QBhJZlLoaleEZWw5PvcCayaQv3FEbobX1UWCks6kKjk028855qk4Yh9VIt9hgkNnC2F8R75F46XS/KlIRstg4SnnAKjlzX9pJlzhP4Nw39FwO1P1BtKtWmuD8OSbltX6FcQr/p5lxODMtTpvjH0M0Vnue0xlk47cvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128565; c=relaxed/simple;
	bh=8IwGTITJ7kca0SxUE7OgZ7aUXBp+mNWBOGIC+9sMbNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz6CWAkX65uQ17wychqU1f3/jO5xGq/ad3vqWK93TVBlWWzO15riIyJmG4CDPYtnYqCSNBl0o6Ux36SxasxWll/kOUAyGsMrI+ynLJhUpaqro6pk23Uz9m5Oqo13iK5ES/a6cKm4ZGoFxcUKjHi8IKhGXD6xL9aXH8UL19398pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HkUDrLBL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0pUwOONr97l+UAUnC1W4rycvMxzk++RRjClUWcBMP94=; b=HkUDrLBLYCKCaBVxeOKl5LnqtQ
	mkp5a0+Q4Mg+PpKo9mPbr2nZdVylbGBDSQPYgJP5T1IGR+VlKXB01vb1hkdN6FSTGsNLmTC92btoa
	yj7PBYDaVesC31qN/vK7CCCUBXGZ4jg7K6AOEiU/4XT9lpVScGzP9gXxx7sdDwKoq8HbJDL2O/cnO
	vsXGbuyNBteuhfj0huy0JGhaarsk3/dL1TiwWRY7Z4Tox1CbaoVUyHaDFUKubj2kXGxpjG6PvcLr5
	oxTU7GII8W8WH8CJI9CGvSHTguVsTYUsBOnJ0Yvp5XMlNLxsREmngsjvtdO63fWomudcwEF8wNHN+
	fPIAPoDw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umL7D-0000000FKG9-0tqb;
	Wed, 13 Aug 2025 23:42:43 +0000
Message-ID: <a18c897e-8679-4155-932e-4bdb9e37f25c@infradead.org>
Date: Wed, 13 Aug 2025 16:42:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] docs: Move the "features" tools to tools/doc
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-2-corbet@lwn.net> <20250814013817.249eb3c5@foz.lan>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814013817.249eb3c5@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 4:38 PM, Mauro Carvalho Chehab wrote:
> Em Wed, 13 Aug 2025 15:32:00 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
>> The scripts for managing the features docs are found in three different
>> directories; unite them all under tools/doc and update references as
>> needed.
>>
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/sphinx/kernel_feat.py                           | 4 ++--
>>  .../features/scripts => tools/doc}/features-refresh.sh        | 0
>>  {scripts => tools/doc}/get_feat.pl                            | 2 +-
> 
> This one is the next on my list to convert to Python, but I didn't
> do any changes on it yet.

Just curious, why does it need to be converted from shell to Python?
I'm sure you will explain that in the patch description (or cover letter).

> So,
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> 
>>  {Documentation/features => tools/doc}/list-arch.sh            | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>  rename {Documentation/features/scripts => tools/doc}/features-refresh.sh (100%)
>>  rename {scripts => tools/doc}/get_feat.pl (99%)
>>  rename {Documentation/features => tools/doc}/list-arch.sh (83%)
> 
> I wonder if the best wouldn't be to have a single script for
> features handling all usecases.


-- 
~Randy


