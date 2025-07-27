Return-Path: <linux-kernel+bounces-747273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E4B131B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059DF7AAFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84722D780;
	Sun, 27 Jul 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/FPxmWm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818789463;
	Sun, 27 Jul 2025 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647654; cv=none; b=rGdcahKgEjyXIKjoDMHX/ng7VzW0obmLfWHEkKoJ0vRIv9UAAgSmCm6wLb2lEk/z2rIJRTtmYxUSl5ndHpSvFOX3+efwc3Dtpxk2s1IuEQN0B4qgPexUBlepvHCxh7/kIOzMg1WFJLY1LljKkMCXDdizVSB22oraJ+5zw471a2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647654; c=relaxed/simple;
	bh=eNZKbzS0c/J7IuDwfdRf57KFwamQJ5ukxeyZwRhspXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/Zv1J7F0HmvRRz3ZRtSaRob9/gbSYd9Gb/xjCAq19Zm0/TTYCRoPRW07tYgDis7yEHorZoP3Nv8DW/JnPnVTtyOAnABFBnYzGjeZ86krenSC8yMkIMErRRyRY8L1LTAfc0tv6yNkyFvTViHlEAbCPsLIU9yOIgoCqz50VNo3vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i/FPxmWm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ux2Y7r0903v5alApOSxRvTGNLT3OOv1EML/ncMGUUmw=; b=i/FPxmWmYSnbdgJ6/p6CQLvhkI
	ZkzwgE/7UqMwchtTqoSrgdytJI1eslzju1nv2njS5bE52PfFcO6/qIs6H9aY6WepORhrCtZriY92T
	7y1J8YZchMeNFjfWgKh9JTfXit1v/8vQLtoZQYJayHvx0fxuLGOcoI7xxtxtOrli+FgQN1GoHhOBq
	soqSmp6NkM7vp8ES3Fustc/OGuZL+yntj07Nvc9xK97cXV6rSqid5bWNacUM4Bv+P6ou79CQZlnE9
	uzNk0681fqz5tEagcyZGZX2psMFxqAJU+UfJX6DjGsYgfz8tPv8Mbp6xGzI0W9FGaj4zsvoSnwF1d
	BnQtocJA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ug7rX-0000000DC3C-45Sd;
	Sun, 27 Jul 2025 20:20:52 +0000
Message-ID: <54aca5de-2f42-4bbf-ac58-2ee6ddf3f8ca@infradead.org>
Date: Sun, 27 Jul 2025 13:20:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: remove broken overline from sysctl/vm.rst
To: Vedang Kandalkar <vedangkandalkar@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <CAJSSbgCRT-EcQTdTKof_gG5eBD1eYZKEFC_9pdQsaCiXx9yQHA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJSSbgCRT-EcQTdTKof_gG5eBD1eYZKEFC_9pdQsaCiXx9yQHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/27/25 12:33 PM, Vedang Kandalkar wrote:
> From 098513ca1d41c0c69f3956a6d22f34aee452afdd Mon Sep 17 00:00:00 2001
> From: Vedang Kandalkar <vedangkandalkar@gmail.com>
> Date: Sun, 27 Jul 2025 23:38:12 +0530
> Subject: [PATCH] docs: remove broken overline from sysctl/vm.rst
> 
> The overline above the /proc/sys/vm/ section was broken and not
> following standard reStructuredText conventions. Removed to improve
> readability.
> 
> Signed-off-by: Vedang Kandalkar <vedangkandalkar@gmail.com>
> 

All of the .rst files in that sub-directory are like this.
Should they all be patched?

OTOH, there are many files in Documentation/admin-guide/ that use this
pattern. Are they all incorrect?

Exactly how is it "broken?"
Did you read Documentation/doc-guide/sphinx.rst, where it says:

* Please stick to this order of heading adornments:

  1. ``=`` with overline for document title::

       ==============
       Document title
       ==============

  2. ``=`` for chapters::

       Chapters
       ========

> ---
>  Documentation/admin-guide/sysctl/vm.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst
> b/Documentation/admin-guide/sysctl/vm.rst
> index 9bef46151d53cd..8f3875d68ac8ea 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -1,4 +1,3 @@
> -===============================
>  Documentation for /proc/sys/vm/
>  ===============================
> 

thanks.
-- 
~Randy


