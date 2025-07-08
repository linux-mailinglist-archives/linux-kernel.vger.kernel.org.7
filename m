Return-Path: <linux-kernel+bounces-721511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287FDAFCA2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21393A5758
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BF2DC340;
	Tue,  8 Jul 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGJLLdtw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2D2DA774
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976967; cv=none; b=NLWYM5zg+xAN6WoFlpez9+u0z2Lx06owfEsANeR/sXP+QKpgUcRnKsNWzmMCWK+PiNx4L7VP4sAHkkFnOPEXCJ1/uK2YS/ltvotB1s9EyebSZL3O1p/H1K2ri/RIrvk1P2y6X/dVdBOzhxfA+dPEpgZCzdLU/E+09THTRLys5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976967; c=relaxed/simple;
	bh=mMvwMZD9hLg9tRND9y9AFG++SVAM192V2riYe9IuSMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIDRCSaU+JT7ptWuyJOFdIrCtoMDMKhLQnTP6i6NWvB++O0MO1NK1mcB4BYeFT4OTiS4nei/IZv9Onpr7TMLb6xhbfd35sE3INX4TUrbliS8uVtbJ5sYqw9GUgBtS5D6fthe76+z/WJURImCWogIaVNwP1q0DRkki1dl0bNB2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGJLLdtw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751976964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
	b=HGJLLdtwqQYgDk6CEYYaeBGd1+d+a4eFHZVu2HwJpIUtoKILl4N3b+qvOTxgUgY+dMvEGl
	lv/YArZjjf3HNBwxPxIjCIeD8+smSUd/0YOEvJ0gZCXtxsvJqQI+/MNXWe5OBQt0oF63E9
	PoSQz22HbiltucZGfeFvGJYjVZluIes=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-HMuVn0YoP322QUdsK3tRuQ-1; Tue, 08 Jul 2025 08:16:03 -0400
X-MC-Unique: HMuVn0YoP322QUdsK3tRuQ-1
X-Mimecast-MFC-AGG-ID: HMuVn0YoP322QUdsK3tRuQ_1751976962
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c955be751aso623479785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976962; x=1752581762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZQq54vH7L1wrrcZbYcmRkAtOhIXsJTAbiqEq5oFXQM=;
        b=I/Z37Izc9CYSzqP/i4sIG04WFlN0gof/kn1Ufh00p8DuVOB9quSCNTR4NP/UjdrKdi
         HB+AVoMEK1ubpQXPRgTkwotjdFvGvDRBZZWLwqJTo47VoGe1CexsvFoyUfP0Ui5rE2Fi
         oyw6+5dqNtZCone/Y+4IKKri2uC3L6ECpZvPWkAHS+JCVhFTAF06LwYeZRAtlJeQRrLM
         KUdtsp3Hpg0hhigZ1B1EYr/6N0VUZI/VwLs56WGD4Z7yka6E0GPupXr7hbhtx0wSht/d
         6LCcr7RjvT6RUl5GCjV14ORJErUJRLdFyEKAEX+sxN7kGt/ccY7Dc3EStSXdZmC3diXb
         adSA==
X-Forwarded-Encrypted: i=1; AJvYcCWQYc7h6MzVfYIg0P/1TBfzZLcjlNWjkY2YoxspeEoDE5XZszKZWKpSP8zEyaShBm5GE8edFjL2p6d+yyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysNjG/Q/oQarW/hQyYljHnvbVkj3Z4lJVxRWqsmQbEzOn65ORj
	FqrCAkYSUB8ohaEWbSc1vIogV3s89uJ89dVM+deAMKqLQk3vetCZFjmIyE/ja/nvYDSLekObbVz
	ewClxJPNdfsOtg6TpHqwHtUBHrLP36rVEM88sAJZCInKOAwd31o0dRmX9vv9CMrynng==
X-Gm-Gg: ASbGncukN41ptyrczDd2OJiMjsmPVwABFw/9ONmUhvD8L3x+J1CydeSNjd1bqej7IFv
	/+TtKNgeR2YJC1qNXOJF5yjIFMkRUznb755bQiGjvFOH5XXi+2Qnq+/KfCGjQjHjQ4hAZcD+Pq8
	Zp9po15iDnGAq24TyVtcpBEvDmUYhtosuqVodz9zgX6O6agoNjw7sm9zvDFcfupWpd9cxgKaz2W
	H5+edcmey/8xfqYWDdd9gDNo21M3J9vNzf99Ltqq9ON4qD+vSI6wjNAVzV88/pfzR9qvb2l1q2+
	qtcG9yG8WW0cI1pHS5fFweI+NA4=
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499248485a.36.1751976962018;
        Tue, 08 Jul 2025 05:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp808SkN2VjVP2MnyxHqj6j8BNYJYFMs1ro4neDCuuVkG+IqYJqwBjuFfETrwpfdtLPBIpUA==
X-Received: by 2002:a05:620a:1789:b0:7d4:5854:32ab with SMTP id af79cd13be357-7da034a52bfmr499245485a.36.1751976961632;
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdbb957sm769232885a.37.2025.07.08.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:16:01 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:15:58 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: fix test for null ptr deref when
 transport changes
Message-ID: <2bqmwv7oyo4zs2fszonhkt5vup5zhbuai4p6ylevkwktihm6au@kokjoj5dgnbb>
References: <20250708111701.129585-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708111701.129585-1-sgarzare@redhat.com>

On Tue, Jul 08, 2025 at 01:17:01PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
>on each iteration, even when connect() is unsuccessful. This causes a flood
>of control messages in the server that hangs around for more than 10
>seconds after the test finishes, triggering several timeouts and causing
>subsequent tests to fail. This was discovered in testing a newly proposed
>test that failed in this way on the client side:
>    ...
>    33 - SOCK_STREAM transport change null-ptr-deref...ok
>    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out
>
>The CONTROL_CONTINUE message is used only to tell to the server to call
>accept() to consume successful connections, so that subsequent connect()
>will not fail for finding the queue full.
>
>Send CONTROL_CONTINUE message only when the connect() has succeeded, or
>found the queue full. Note that the second connect() can also succeed if
>the first one was interrupted after sending the request.
>
>Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
>Cc: leonardi@redhat.com
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
> 1 file changed, 16 insertions(+), 5 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f694..630110ee31df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			.svm_cid = opts->peer_cid,
> 			.svm_port = opts->peer_port,
> 		};
>+		bool send_control = false;
> 		int s;
>
> 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
> 			exit(EXIT_FAILURE);
> 		}
>
>+		/* Notify the server if the connect() is successful or the
>+		 * receiver connection queue is full, so it will do accept()
>+		 * to drain it.
>+		 */
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>+
> 		/* Set CID to 0 cause a transport change. */
> 		sa.svm_cid = 0;
>
>-		/* Ignore return value since it can fail or not.
>-		 * If the previous connect is interrupted while the
>-		 * connection request is already sent, the second
>+		/* There is a case where this will not fail:
>+		 * if the previous connect() is interrupted while the
>+		 * connection request is already sent, this second
> 		 * connect() will wait for the response.
> 		 */
>-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		if (!ret || errno == ECONNRESET)
>+			send_control = true;
>
> 		close(s);
>
>-		control_writeulong(CONTROL_CONTINUE);
>+		if (send_control)
>+			control_writeulong(CONTROL_CONTINUE);
>
> 	} while (current_nsec() < tout);
>
>-- 2.50.0
>

LGTM!
Thanks for the fix!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


