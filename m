Return-Path: <linux-kernel+bounces-721419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54874AFC8F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D433A220D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635A2D9EC9;
	Tue,  8 Jul 2025 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGyi8GX/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5992D9ECF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971985; cv=none; b=fdlPjge8ax5dV/YPGwzeG8IuIEpNhYbyA6tiXSGTOWEheqos6vy4/v/BxNEsNa/ffY+ehxWUX3PXRrWZB0v9+VTuKDSo7+yXMsFRSJ5jpegJUoS58nywMfOnvlDvVzELlVwpDob6RqYl1NZCmjTGEmCiQZ/HkGcH2qOCWl+Guso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971985; c=relaxed/simple;
	bh=1un7ouFwyBTSYIMY4zpatIXNYHrEz24iVPhqyQXJbbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnsPjOxQPN/fFsM0X6EV5Qs9m+j5ZG6rktIE/wKFpgtB0dZjW5gvZgx3H+DdBverhVmmRB4DVTBhjnPNnORw3m2AENAyHdhFwt2nhsyPRV9atIVdsh5AqRlfrfDSkCLwWtCrM8Xt1wJ6LaiCiUweKoHu5ZW87WfuKop8OmiW/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGyi8GX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751971981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
	b=XGyi8GX/BAF+tOmfHqd+RUxlCdsxzRVbD05HGxZ4kjHqn77OVe3cH1oDFRK3iEp19O6miC
	2iYcWQ5gEJbkXmhZcZg5rxFWU3tGzHXpC+KHzOz5S7HI46bCAzBuyNEOWIDBOcmME0ehI0
	4hpTPjKK1AOxhEM86Axbj1IeOsakvVs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-MwWP6XeiOK2gDkoLEBegIw-1; Tue, 08 Jul 2025 06:53:00 -0400
X-MC-Unique: MwWP6XeiOK2gDkoLEBegIw-1
X-Mimecast-MFC-AGG-ID: MwWP6XeiOK2gDkoLEBegIw_1751971980
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a42d650185so55372561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971980; x=1752576780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=315fIenJWHN1D0z1wGXcALO7wPGrPSPVrNC7//PcDEU=;
        b=BfWf9q/dXGMroVv4VRG2R9NaQY79xRRWxVzUKraqL245qdDz6JgiP6itd0REtHS1S9
         CGF0PTLhI1pz32PTnoweLUQDY7R5N9CBXJKUmX7z6sBwYg34C9oDeGt4y5jjzrp+WPbY
         OxXewyQ5RwLeHwZeSrUKc2iloThnMpjkRdwubUEmm/cVEC4a+varNwt8cfuoqLQlWL82
         yGwWJJV1a4TUMZFSiaPrKQfphLZeSccdsvpZV2d5iU8PUTTwuQt63If5kBwOfUk9GQAM
         /NuCsOATTxZtyJJpLntT5vTTlLLKrmDrrS+XO/oOuE9HllLBf7BknFYkbdpSeNwqitmK
         m4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKPAz+QjhU8p/IH/EUga4c4nJGRUtCJS+3P5NTrwU5Srzc50TLx5gQfJzVc34465UUIv8/HfqnN6H2rlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnNYN/CXhiMC8I3WbaOih1ehX7mILSwzQnXec70VRc+mrA7xK
	+Y1CG98ThH2BnBOLUBXqWeO/mDU/BFMn9jt/fyHSYQc9eyHxmGP97q1KTRtlSygeDwcJ8eGkH9/
	I+2v/PregFHZAqwJd7H/vaiSv7JzM7hqZvzJY1zVrhyxMVXT2E9revIeCo6ODusZBvw==
X-Gm-Gg: ASbGnct2W1JdgkEm2Yo3Glx6CGj2kiEluxdWEAUj5hlxoyj4iSlhE4h7S5XETF+8lDb
	pBZNDr9G48YpKVkhvFsdB5Pq11sePClNarxQppjPx3RNsBekMMz3dzWdgwi0x2hXcWcFbvqT33c
	ExVM8gxGqwLchv6ClvQKYQFE3E8SCszVzYK2oo9pqUmPnHCyA3RDoxiC/+DDtz/nrHYmhoRqN04
	GLLczASFxi4aQyPgH99QIPLdMzdg9rrMH4+yO/tv85TAse6IIje7cDJKcmSxMQVQXCxHxx6zbPa
	4XOuJ/wSkcdXGU8WXA2TzBJbGBPH
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966911cf.47.1751971979584;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzvc7u8j+WEd/fQJxoq873TigcJMGy49ozcWVyaqRVCjfg4qBqi9tMZtBOChGJAAMzAMDFrQ==
X-Received: by 2002:ac8:7f95:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ae5afc23mr175966551cf.47.1751971979134;
        Tue, 08 Jul 2025 03:52:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa85edsm77449631cf.74.2025.07.08.03.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:52:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:52:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 2/4] vsock: Add support for SIOCINQ ioctl
Message-ID: <lh5vti5lmcxddhnfsz5pjhu7oepcbxcflqkyhlpwnwqzbe7tku@yw7bwfgafcby>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-2-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:12PM +0800, Xuewei Niu wrote:
>Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
>socket. The value is obtained from `vsock_stream_has_data()`.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..bae6b89bb5fb7dd7a3a378f92097561a98a0c814 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
> 	vsk = vsock_sk(sk);
>
> 	switch (cmd) {
>+	case SIOCINQ: {
>+		ssize_t n_bytes;
>+
>+		if (!vsk->transport) {
>+			ret = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		if (sock_type_connectible(sk->sk_type) &&
>+		    sk->sk_state == TCP_LISTEN) {
>+			ret = -EINVAL;
>+			break;
>+		}
>+
>+		n_bytes = vsock_stream_has_data(vsk);
>+		if (n_bytes < 0) {
>+			ret = n_bytes;
>+			break;
>+		}
>+		ret = put_user(n_bytes, arg);
>+		break;
>+	}
> 	case SIOCOUTQ: {
> 		ssize_t n_bytes;
>
>
>-- 
>2.34.1
>


