Return-Path: <linux-kernel+bounces-871178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F534C0C968
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CBD3A431E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68E2F25F5;
	Mon, 27 Oct 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjSB/rw0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32E2DE6F5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555888; cv=none; b=amKmttmSAE1NetW4LqybFZkd3lP1fvF22Df1wXsdeqhrqEg62XNuCkNCZDZmmkd3Uspn+EaGj2KTIJhjJYc9h/69CBIpDHxFY6V1ia7/Lp6dIVf7yWp2+6s3w4JOIuB12Wd88qk2pHZx3Ju19dQOVNftpnKsQohUogonotX0QfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555888; c=relaxed/simple;
	bh=iTaTRpuw9icqIuKpG7+Q5oM6XCGyTVVars9jKhLnA28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsrvvW4ZVZYvm1rFIDVIOkxcEH7xdTvsBUZagPd3oiXRKyXSD/3v/8Zk9mc4vgYpl06jgf34fo7LsOFRTuAk0pIiNBogFSw/T8215uyVOgZt1oSURkFgsKw//IoeXv8BikGdyDTgO6JKhv9TkzM3kAK/a2XFg2dyJxnEMvLCgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjSB/rw0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761555885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDbOn+fWxz6W8IPDqDbvyTLi+OfNKI3sHuCQEAiPVss=;
	b=fjSB/rw0tFn/2MnsveFIRj6EzDDvaesBzvF9PqW2Ih0yA6xadwCDI1NbLFTkQMqZ0BbGwE
	rP3fTzAewtdDJcgIiMuB2M0DG+jTUnopWCUoFTI9GTEExzaOFiWaUM//70FdanGgbKMwO7
	ljW1PbP1CoMOmUx3vQYg7tk7qG5ltP4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-JJ75XXmcNZWEPwy9YsId9w-1; Mon,
 27 Oct 2025 05:04:42 -0400
X-MC-Unique: JJ75XXmcNZWEPwy9YsId9w-1
X-Mimecast-MFC-AGG-ID: JJ75XXmcNZWEPwy9YsId9w_1761555880
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D25B195608E;
	Mon, 27 Oct 2025 09:04:40 +0000 (UTC)
Received: from [10.45.225.43] (unknown [10.45.225.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A86C13000223;
	Mon, 27 Oct 2025 09:04:35 +0000 (UTC)
Message-ID: <0466a326-5e0b-4099-a2b9-5c5a6baaadfb@redhat.com>
Date: Mon, 27 Oct 2025 10:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: spec: add missing module-name and clock-id to
 pin-get reply
To: Petr Oros <poros@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Milena Olech <milena.olech@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Michal Michalik <michal.michalik@intel.com>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: mschmidt@redhat.com
References: <20251024185512.363376-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251024185512.363376-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 10/24/25 8:55 PM, Petr Oros wrote:
> The dpll.yaml spec incorrectly omitted module-name and clock-id from the
> pin-get operation reply specification, even though the kernel DPLL
> implementation has always included these attributes in pin-get responses
> since the initial implementation.
> 
> This spec inconsistency caused issues with the C YNL code generator.
> The generated dpll_pin_get_rsp structure was missing these fields.
> 
> Fix the spec by adding module-name and clock-id to the pin-attrs reply
> specification to match the actual kernel behavior.
> 
> Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>   Documentation/netlink/specs/dpll.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
> index cafb4ec20447e1..80728f6f9bc876 100644
> --- a/Documentation/netlink/specs/dpll.yaml
> +++ b/Documentation/netlink/specs/dpll.yaml
> @@ -605,6 +605,8 @@ operations:
>           reply: &pin-attrs
>             attributes:
>               - id
> +            - module-name
> +            - clock-id
>               - board-label
>               - panel-label
>               - package-label

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


