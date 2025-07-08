Return-Path: <linux-kernel+bounces-721421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA8AFC8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D69D1711CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D02D8764;
	Tue,  8 Jul 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI92zCoM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558E267B9B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972091; cv=none; b=iqJqNihWzAMMY166hjDDwMCXr9a9F/t5PsdI6bYSNqDnE5ZBm8ZPQb0m/fmIMr+WvkO6lysjOD93YmXCgHgY3I+22AUO9zwrxxhAmuUyZV2BNCKbspVxWrcwFa4li8EqjjhDb3MlDHqdENbIdkcbXlC6nJwcTXew7sDZH+1RU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972091; c=relaxed/simple;
	bh=pt6duYiMCIehtx4IxrjJmNZ1YzZaoG3aJy7HoAatvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeAXVZdw5QKbmY4WPJCwmELQU5YNVztNH2lvHrMTkWQshWsgon6fPqHx6rUlD4PxIwzEe8dsaBDc4iv4sHO4y6hYKoa4j/pWmOWh17f932dkbflooK1pcAhDES7LJsaaGh63xQMazjRzHQU5ATnoNgC6QQBowmJYwtzCCvmGkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GI92zCoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
	b=GI92zCoMp0TWkjJDZyJ47jPze8MoOLG5s3GmikRFb4Sab1HJSBOR4Vq2/kVyfMG+Wk/NVn
	P1zzu8YmukUBG0AYFw4xHgCajFlolVF2QUXx2zuGVVnAeyIYAcgl3Aij9cnHAhgprd2qme
	/4PRv3PBdQICFcH0VWPbTP+Y6xsSwak=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-0Se5acErMLq9SH7JfPZC5g-1; Tue, 08 Jul 2025 06:54:47 -0400
X-MC-Unique: 0Se5acErMLq9SH7JfPZC5g-1
X-Mimecast-MFC-AGG-ID: 0Se5acErMLq9SH7JfPZC5g_1751972087
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d444d21b24so682016685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972087; x=1752576887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
        b=mGy6CvUTqPfUdJnmXr1uIN78JlpLr/IDEvVudxkTV/+yVRfgHx+miPwRJRm6kLmnlP
         MnpLm3hkN+nCcqJeF1dp1ci3Hfsz7oC80IQK4uzVrNuHjtUj/0NzK+U7Pdyz/KtGoh8G
         dIlW3YnFXtmuwtr9e2q6KRTsBvg1jz9pUo1Klxn6qQyNtG95t4TbRS23l5nSe208ZBvx
         1Vo3MFi0ClA8QAjnRhF7zHm2XcKCFj+eKFbngZ5PV+dwy43ychItUFaOCUAZpNH6L1wp
         tyOCPCPYnYGCSaKSMN2tXx8x2NPB1n9Mpt9bOVaE9B1tZ3j0Yxtu0wYU7BXE8uIh55BM
         cOVA==
X-Forwarded-Encrypted: i=1; AJvYcCVrfNCAQ95zi+1+z8ltfZNRoQr6NYIBefzt9nFtrofu9B5Qiz0dB0URZbC8LJ5MFpX7gsLfV0+w/gUuqrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXUAfgudQH7PoDAFkCQ7zB5NZ9X6OAaTAKuNDI/c3ha08bE7v
	tbOGzAyWXn5BwyS1UA4O6prypcDScpXVlmZ5+nMNnkZC6Vjl6gZ0GixE2k06d+UL2GBSpdQlx1N
	iQFUwVIw7RviFa16jzi+2vwLYW4yWI+2YJg+BOaEdu8nWGgyXJiJJKAEMB6XSdWaUKw==
X-Gm-Gg: ASbGnctpUnadXLsRAUABqzCcHEIWkq1u214xoyx1O8k9VYezb/bfE1HNC65K43DSq15
	ujkvYvAq65EF3SSnbg9ZwvvYVIlJEAIRjr2g8nTD0GO3POJ1DT6uEa3Mn5CfhbNGdM/abkz7Sin
	26BWB8NLtXXONDF05GWu+XEsbBd2AO2NJfeZOwyV1/nZsD85y0pw7T/iQSHSFMZQk3jjAThx1Xg
	ejCL/hOuMiO3gAo3j5rJNWgu5bs6Geq1Cn4qd/6jmQAEP0dgX2KO9TsAIsHk8iOoXTXZy/d7DUL
	dGd4m17bE2tM2sNIIEweni0rCLuP
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344298185a.51.1751972087279;
        Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGODJ+k5iQwpBD8zrN9hRkPcNeibB7riAG/EN8ncnQ9dHTW0DTOP7oRQy4VBda/jQ7Oc5xqfg==
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344292285a.51.1751972086595;
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm757715685a.86.2025.07.08.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:54:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <xvteph5sh4wkvfaa754xxakufgwkjzjawzfttnfqcvmei2zcpf@ig6fawckff2h>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:13PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int actual, ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, &actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret >= 0;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
> }
>
> /* Create socket <type>, bind to <cid, port>.
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>
>-- 
>2.34.1
>


