Return-Path: <linux-kernel+bounces-751246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AA8B166DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9222D623958
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6772A2E3364;
	Wed, 30 Jul 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rpeva/s9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DE2E0B59
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903520; cv=none; b=f+yq1zToI1bDu2v46r0nY7E1D3U7qaQ74x0s/7tMdNmuv/yFb3hRNxoCYqD3rVDodf3rX4SBpJktR/bdoH8SrozuYwq7iIcDQ1NHc+FU5K7CDJLBhtvjTqv8IgCqi/CNh20EZ/mbSErkMqhJt5+n3GoEst78184vIyjTFOx1zKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903520; c=relaxed/simple;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jppIlMnkzqXDaYwiKKEtwPj4aJLQkT0cjwnLATXt2jIs1le7PBK9yFn1+9rgsq03z47XIRhZExPdnWrwIVnQERMkAUOWIV1Y4hdryuMWEuCHmsZ7esAwEKGLmiHcEOWtN5CrjKIuO2l8+IAJUnb8Aco8wKuW57SNT0qjWabTJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rpeva/s9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	b=Rpeva/s92OtuV6W8YH+RFip4PaeYGQJSFhvE1/8TYK5mZaxDGLGbMxXHMZQAY4gFTZq1On
	2tBQPu0+WbGfB7gbgeRI41A0G79dAVd5dRWncEp+BJhYLP+828aohDmxtDUroChmLn/wye
	hkuONwprziE6kp3PkeSLhe5nm4OxGbQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-ChkXVaVbN3SwQhCPr5GYaQ-1; Wed, 30 Jul 2025 15:25:16 -0400
X-MC-Unique: ChkXVaVbN3SwQhCPr5GYaQ-1
X-Mimecast-MFC-AGG-ID: ChkXVaVbN3SwQhCPr5GYaQ_1753903516
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8812640a640so14498239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903516; x=1754508316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
        b=KjpyF/MtJpxbcKuqh+TdJCDmNBy0lx/WNc1CY0QxP3//+xED29QduH3c2+jQYu5/Zh
         drlB52+2z4i/Edy/BcU4+ZdTg8Ku51AHCwrptZ8pdR7og9d5l26pU2CZe13faQo5cdCf
         LY+dXKoXjUCl9H/ITBAvngAyoCz2WHFbbDCye1/dyBAVQhGjebJWjssknVVVGTAs9HgT
         7Zk0bDRKL4N+kbDnVoe0omcKOnyFxvaW53XfdAFV1G3wN41m15xhrsJ9WWg5iawIFqvm
         QGe/DoyEVn6cR/zQd2aEZYAQ27WVm7v4MJX3vcBpivPO14EKQ0KWSyOFQnB86st4Xt4p
         AN2A==
X-Forwarded-Encrypted: i=1; AJvYcCW6CDY4zc3QJ9VQEh70dC7urZoi8B9bIAvrinzYtxdwSagq5FDBpFH7Y9dwgoaKF2OMfHsmwm5LZrM9Ws4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPy5dz2CKjypiCoMOkmeWF5BvMk6KYkN2MjaU4TjOBcUxm/Gtm
	jSG8Mtoh5lbo1vIuO2zeXNxqKt4fbnslNF1Q0gmQk0cEQBzaIh52aEtnM5p8ni2oIr981Pk0U4Q
	n6uoJlbZQ6QCYRMS5f9P4WTucWArGTJMaYIIMmxQ0o96IaXN72o9rVvR3WMoHoFHn6w==
X-Gm-Gg: ASbGncsMHit4nFH4wLzFRhvU80e4o8JFJ+je3fahdzHu1G0kQCSt5CHt3E+jJfoGG1t
	1ZgEWTmtut4bOL/jkvan4fOopd9HGM2qWYdNaSyCZwCTqXcjOE1/YhT1ZHzFT/DKVXkx8HWU/+g
	qUEcoypIa3e1Nz7PA6+Hx2hr0ewU/423UbVS6Q5HVhtub+h7jtwkcQFICw9Jj0BHVXDWiPl6Nxk
	3VUQR0OcUYbWPKqYK8WQPK786t0flJuGSGwtiVl0rlRK/mm3F/cwI2O3Z1/fordAlrSMQgLXYr6
	1Fl6j4WzS2bHqGyQftQ6Vb9chCT6Tz5d+3ZtbbPmQFRG
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779530239f.13.1753903515964;
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpCFALf7IPXCoobyto93MhXLiAr8cMVLoJgoZHBK0x34eSoXpHWsaWyDpGqrEeEKztmMvPQ==
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779525339f.13.1753903515535;
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 0/4] 9p: convert to the new mount API
Date: Wed, 30 Jul 2025 14:18:51 -0500
Message-ID: <20250730192511.2161333-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an updated attempt to convert 9p to the new mount API. 9p is
one of the last conversions needed, possibly because it is one of the
trickier ones!

I was able to test this to some degree, but I am not sure how to test
all transports; there may well be bugs here. It would be great to get
some feedback on whether this approach seems reasonable, and of course
any further review or testing would be most welcome.

V2: Address "make W=1" warnings from kernel test robot, comments from
dhowells, and some kernel-doc comments for changed arguments.

Thanks,
-Eric



