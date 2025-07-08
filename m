Return-Path: <linux-kernel+bounces-721445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07167AFC94E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506AF3B506C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A22D9484;
	Tue,  8 Jul 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMz2PhrB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF5215F48
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973433; cv=none; b=mb8QiuElYFVrzuSqsQGZai26PpsNpgsHHDzbcdpE1dNV8bAqDztXqkUpKS15eeKs+Yyk/PNFy1VQfFBBlJD/uB0U/fqbg2p15Gmd0V3Qg+Y2n6D/NGik+QvjPraQAT0wlksDMhuOitsgnpddWBseeHyJrQoavcYqBsgfZF1MIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973433; c=relaxed/simple;
	bh=SW4IfHix+f4Je4esfBdglGbT4aI4+HKwBw41uiZTcKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEampsP2OBNMXIv+9ibUNH26QfmX+iLg4knvj4Hvjb3ClnXvkYVXURGHIBlwA3YEx9Ui+3yED8xzyyFVmoYX5z/njjshdD6waSwr/I9SMCFZGazNZtPXl0XcJab/VFN3qmQLSk34rW4oZ8X5y7ilkckV6d7dTkfYHQNthHpKfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMz2PhrB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751973430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
	b=OMz2PhrBCqvprQCjkteCM+syI6brAwkngfkclP0eHBHJ3IYz9K99yqM8b9XV6DCN9az9bh
	Y9X1+tEM7xigIeSFvtAUaLeH0w0ivqjZgTQZA83WoVrmYpDdGfDeuSRVo2GQQxryptuOAK
	/qfI3Is+eunyRWcA5rTQebFHxDqFwu0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-xlm6o7hCNhKfGN68oenCeQ-1; Tue, 08 Jul 2025 07:17:09 -0400
X-MC-Unique: xlm6o7hCNhKfGN68oenCeQ-1
X-Mimecast-MFC-AGG-ID: xlm6o7hCNhKfGN68oenCeQ_1751973429
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a584d0669fso88814711cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973429; x=1752578229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
        b=jjyFrwMTsJWPb+W7Vz3l472Vh5SOrYYrTQ6u5r8h6Uxochy9e66nslMHvNBtH+7SBk
         7yBSmtX0Jv9Ie8JCsaVh3fJhjw69TQDfksgTLKfnAIrVxs291zTl0nT0lJLhpdHLoTTz
         Vm0PpHB7AKg+BHR42y9sC+OhH809iLr7AwefWKwBzfMAy3Aqnksib/KpVj5PaVYscwvP
         EypJB6MfJpfwWpWd8QLwVMByIdY1mMCiqtC5rsZ7+SyX1mlQRJVIK+nfOVQs11NEMWff
         Ovg4cOmMTIuDxAV7y8+jnLzc5lIKXJ/W+LDtlw/y2vxWiftFHxEaUuCdbhgx734bs6q2
         2Ttg==
X-Forwarded-Encrypted: i=1; AJvYcCWRj9/cuEYy6I97f6JVEE7TtoAQOoIeBPf56tHBBPFRv7PfAA90h5t83UjVzLVNWj6rc2PCCGRTpcA3PcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc1nDVxfwZLC2Q3B/dOUDFQKaxcPVLloRUItDBFcZxLSIT+z4
	D0kY77fg0IE36NrftAy0RhifaNAk9RbyVIdgQXxrAhEpYqfd/joc+/IROruqBdSXVGshW8Z3Z0c
	6EKDhx0466jRJifMzyUZLJRmm+gsz6nV/eaJGCK2yfaes5jdIl5nYparxp9jT5OKrVw==
X-Gm-Gg: ASbGncsTomrhruP4kfK/wl1cNCuKOt+/2txpP+ObxSH/z98B+U19/KvuIeAzXZXA05p
	ZhyftNm5tQvQPrWDGjtWMi9fgtbdQ8m/4V8AlbPlapa8dV+ofV13EJ9zW4WRr/KYmSzALXcc+Vl
	moO1/ritHrXQu80pMwOx4+3SemwOUS1/Dq8zlE7CgtOd1Vu77bqorqC0QsoMFBX052ixrR4JuL2
	/pT/TODGTVBpq72YNp5ASaetiYthHQc87E5SUs6PFtK5YNHGYSBgJGZSozdUCa2uZhCuIEmpBHK
	SO1OOtymjqACptaQe9e0Fw66VC6znw==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37844056d6.34.1751973428708;
        Tue, 08 Jul 2025 04:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmdZdg7FkyHCs2tm7yZmuVxog/GLdnlBjbdngjYdDrQNIKIT5juBSVSyb2m4opt+Qg+0n1ew==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37843036d6.34.1751973427927;
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac2csm74424756d6.95.2025.07.08.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next] vsock/test: fix test for null ptr deref when transport changes
Date: Tue,  8 Jul 2025 13:17:01 +0200
Message-ID: <20250708111701.129585-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
on each iteration, even when connect() is unsuccessful. This causes a flood
of control messages in the server that hangs around for more than 10
seconds after the test finishes, triggering several timeouts and causing
subsequent tests to fail. This was discovered in testing a newly proposed
test that failed in this way on the client side:
    ...
    33 - SOCK_STREAM transport change null-ptr-deref...ok
    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out

The CONTROL_CONTINUE message is used only to tell to the server to call
accept() to consume successful connections, so that subsequent connect()
will not fail for finding the queue full.

Send CONTROL_CONTINUE message only when the connect() has succeeded, or
found the queue full. Note that the second connect() can also succeed if
the first one was interrupted after sending the request.

Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
Cc: leonardi@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index be6ce764f694..630110ee31df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			.svm_cid = opts->peer_cid,
 			.svm_port = opts->peer_port,
 		};
+		bool send_control = false;
 		int s;
 
 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			exit(EXIT_FAILURE);
 		}
 
+		/* Notify the server if the connect() is successful or the
+		 * receiver connection queue is full, so it will do accept()
+		 * to drain it.
+		 */
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
+
 		/* Set CID to 0 cause a transport change. */
 		sa.svm_cid = 0;
 
-		/* Ignore return value since it can fail or not.
-		 * If the previous connect is interrupted while the
-		 * connection request is already sent, the second
+		/* There is a case where this will not fail:
+		 * if the previous connect() is interrupted while the
+		 * connection request is already sent, this second
 		 * connect() will wait for the response.
 		 */
-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
 
 		close(s);
 
-		control_writeulong(CONTROL_CONTINUE);
+		if (send_control)
+			control_writeulong(CONTROL_CONTINUE);
 
 	} while (current_nsec() < tout);
 
-- 
2.50.0


