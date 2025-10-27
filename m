Return-Path: <linux-kernel+bounces-871189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95068C0C8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9E0734BEAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21E2F3C12;
	Mon, 27 Oct 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4EipB+W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B02F39B5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556118; cv=none; b=cNrNQBjSyntZTFWjwmh0l5lu/90804iMcQyF8I9ykC9Kgo4WE0kbCC73fPBYnDtNnWi0c0xGDo9FZCyfFluxqbAOJ8kwBN4JmbI+vkwIHWya6q4fRsRXjPnPXGLp5+M66VrxyxS2F4J7GBnBpSVfeRqEd0+uz45Z3EPYM3Gx0k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556118; c=relaxed/simple;
	bh=KMLUCx37oodkWW/ecGieGDWDnscNn3RkvSQo3ZEJYSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX2AV9jcfmgfXsaKdHEDohzMDX2DKm9wAPeHHdM68rR3MpqqrTdZb+d25sXLwXke+kquxRKkk+XiXjFL5iEfB2IsFKuHKA4egGSZCJg4xpPqzhGDQeqNTvkQT60iYpb/ylAv5aLWDJzlHTbZWcca/HSZJPMldEmjhLWluOJKAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4EipB+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761556115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTIAdX/dwL5w1YKSS37dOxKFZ3s8yXzfHwYPH8iK7Nk=;
	b=O4EipB+WkCYO2p6RFvr2JH5SvCAPxXgiNqa2uvsRz77cTLGgs6LqX7xpYUMwSsVFNCfjRR
	JLXuReu0Q7+3fi3iGxi1XlFSRL3cuelvFIgUu0oJ3QrunIO3USMQRg6wx92cgRk5U0JfFt
	KTFp71KQDlpGhIQOb5GZcPbjZAkHZns=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-JhhY5nsMP_-U--IKn9Wj1w-1; Mon,
 27 Oct 2025 05:08:29 -0400
X-MC-Unique: JhhY5nsMP_-U--IKn9Wj1w-1
X-Mimecast-MFC-AGG-ID: JhhY5nsMP_-U--IKn9Wj1w_1761556108
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308BF180035A;
	Mon, 27 Oct 2025 09:08:28 +0000 (UTC)
Received: from [10.45.225.43] (unknown [10.45.225.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94A9D19560AD;
	Mon, 27 Oct 2025 09:08:24 +0000 (UTC)
Message-ID: <b479b307-b590-467f-83df-837259a64b6c@redhat.com>
Date: Mon, 27 Oct 2025 10:08:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tools: ynl: fix string attribute length to include
 null terminator
To: Petr Oros <poros@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: mschmidt@redhat.com
References: <20251024132438.351290-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251024132438.351290-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On 10/24/25 3:24 PM, Petr Oros wrote:
> The ynl_attr_put_str() function was not including the null terminator
> in the attribute length calculation. This caused kernel to reject
> CTRL_CMD_GETFAMILY requests with EINVAL:
> "Attribute failed policy validation".
> 
> For a 4-character family name like "dpll":
> - Sent: nla_len=8 (4 byte header + 4 byte string without null)
> - Expected: nla_len=9 (4 byte header + 5 byte string with null)
> 
> The bug was introduced in commit 15d2540e0d62 ("tools: ynl: check for
> overflow of constructed messages") when refactoring from stpcpy() to
> strlen(). The original code correctly included the null terminator:
> 
>    end = stpcpy(ynl_attr_data(attr), str);
>    attr->nla_len = NLA_HDRLEN + NLA_ALIGN(end -
>                                  (char *)ynl_attr_data(attr));
> 
> Since stpcpy() returns a pointer past the null terminator, the length
> included it. The refactored version using strlen() omitted the +1.
> 
> The fix also removes NLA_ALIGN() from nla_len calculation, since
> nla_len should contain actual attribute length, not aligned length.
> Alignment is only for calculating next attribute position. This makes
> the code consistent with ynl_attr_put().
> 
> CTRL_ATTR_FAMILY_NAME uses NLA_NUL_STRING policy which requires
> null terminator. Kernel validates with memchr() and rejects if not
> found.
> 
> Fixes: 15d2540e0d62 ("tools: ynl: check for overflow of constructed messages")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


