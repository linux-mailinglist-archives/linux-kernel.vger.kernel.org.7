Return-Path: <linux-kernel+bounces-838895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD98BB05F0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966923B6332
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB32EB863;
	Wed,  1 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEdc9YYd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E21AF0A7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322552; cv=none; b=EnHmnF1MejPgq3AT3yyTPZnsp6z2L7FVeGbplweZUxSevd+gHiIqKUXFeGfM+lAVPV4us5KnuiCTQdTw7VZfeeXNAF0ICntll+St+1UN5SKbgXb28cGt9MTRvI7a0GzcDR6h30G7cr+b4I+LRfgKu/0VLIq2WHORtU7YwWhjkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322552; c=relaxed/simple;
	bh=Pz3zaC9C//BJbpq9swynHhRnQq6TWXb4/bvSdHkQOEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDFwnjWnXUyiIosvO/obwVuPpf+FquvPjtxBZ3KYSIjZ/jFF01ymeRSj4hwy2FpLCmbtKn0bBKH8wbAS6r9pa81f28z2MX013kJ73nLfuBNbSSXpYW3qG0FQxeKGajjQpWNw2RhL3Ne/iVc9SVBrrxtS3VfOhXbPSQmWMInRcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEdc9YYd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759322549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pz5DiaUIUpH5xDPSpcYQUbcl/M7XnZ0YA9dOeOfZYII=;
	b=aEdc9YYdLF3aTDDtz+5LlzyWJKoCcOhatY2aJ7p7CERFEOHHXvjHMObmOCf+fI0TDJu8dF
	6mO/00ywn8+14SnE5aPvuT3jhSJcDEg1Seh/M/Nbnf9pZeLtskV8BPomnToULOEC1q+oZL
	kr3Kfc1RS37v0VoSSYFlVrZfdj5MSGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-G_xKfARVNr2Jo5L4fw5brA-1; Wed,
 01 Oct 2025 08:42:26 -0400
X-MC-Unique: G_xKfARVNr2Jo5L4fw5brA-1
X-Mimecast-MFC-AGG-ID: G_xKfARVNr2Jo5L4fw5brA_1759322545
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650301800576;
	Wed,  1 Oct 2025 12:42:25 +0000 (UTC)
Received: from localhost (unknown [10.72.112.73])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6423A1800576;
	Wed,  1 Oct 2025 12:42:22 +0000 (UTC)
Date: Wed, 1 Oct 2025 20:42:17 +0800
From: Baoquan He <bhe@redhat.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, coxu@redhat.com
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] dm-crypt: remove ineffective comparison
Message-ID: <aN0hqT/iTAWodgXJ@MiWiFi-R3L-srv>
References: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001120254.24980-1-suchitkarunakaran@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

CC Coiby,

On 10/01/25 at 05:32pm, Suchit Karunakaran wrote:
> In restore_dm_crypt_keys_to_thread_keyring(), key_count is a global
> variable declared as unsigned int. The comparison key_count < 0
> is therefore always false and has no effect.
> Remove the dead comparison to make the code clearer and
> silence static analysis warnings.
> 
> Found by Coverity: CID#1649028
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  kernel/crash_dump_dm_crypt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index 401423ba477d..39cfc13ff350 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -115,7 +115,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
>  
>  	addr = dm_crypt_keys_addr;
>  	dm_crypt_keys_read((char *)&key_count, sizeof(key_count), &addr);
> -	if (key_count < 0 || key_count > KEY_NUM_MAX) {
> +	if (key_count > KEY_NUM_MAX) {

Sounds reasonable to me,

Acked-by: Baoquan He <bhe@redhat.com>

>  		kexec_dprintk("Failed to read the number of dm-crypt keys\n");
>  		return -1;
>  	}
> -- 
> 2.51.0
> 


