Return-Path: <linux-kernel+bounces-741925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F018AB0EAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262FF54438B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA026E6E7;
	Wed, 23 Jul 2025 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU71UxNf"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D20185E4A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252738; cv=none; b=IPeVZDFj5q6KnzhS4/6Ecl7KAkyWHzDN3rozJzRZvuq/auA3Lv8G/nm4tNeNFNPd8BWU4kvjrOcBo8awWiNr53krM6n0D+WAcpU+WBRXuHQgZrYpD2HFAhyOzf9QQvp5qHtxRfHWL6owPcHCUXKHFPLRC8tZPxcu/MzSjuuyhAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252738; c=relaxed/simple;
	bh=kppjr8VXRD3ADfgRmJ8+FpIYw7kfM/MModcFvlNHGIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jaN1pnIalZOf9WTJv1mpEb9cVyImRTFP7U12p5cJ6twwr/YmOvnof21qrJdvrT2HlLpBYWzFz57/FATTxIoR0pZmaAdy9edAyVaOILu4C6njd/msYYxVfldowphzgAM7MI0aMbQ5fQWp5UVz+7p10P1v8/f8TRwCIDpkz6b6NX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU71UxNf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8b838203d3so824001276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 23:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753252736; x=1753857536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqv+T/SIEF1Kbneo/Sl7fRz3B0vTyt+hrI5wqB0sj7A=;
        b=KU71UxNfKNBIcIj3pjMNXMkR7E4mjZ1wyMXXsEgpChnWb6p+uYOFlB7yV+Dlx7b4ja
         Lnnfg1CV0TThEX79XBSQa7CYFvwmRDHoxr71au+XrwBmo3ZDsDIcVAZcKxtle9uksMAZ
         +X57JfLVIFf+QmiMqFE53DxN77kr5Egkwi4UR7ZK2eUznJ2HHV8RjISOUHOTuZY7ZmJb
         CybhwNnk+Oskj3GGU9SW9zw1rL8TWdKFHsD19jVAgwkYDpHhZyhx1xTa7QSufnzaMP6k
         9rvRLIRP/1PCtkuNIPQxkPzsPylzgy3esXpuEuhih4ZG0VAb+MEAw15V5iACVFgiIa1H
         iCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753252736; x=1753857536;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qqv+T/SIEF1Kbneo/Sl7fRz3B0vTyt+hrI5wqB0sj7A=;
        b=KAMTk/Xil8snsgR6Vvr/9IFsY3OpVVLqsVPOcFUItjslTeLeIwWXFcsOR148/YJP4N
         FsMN2iTGVef2+EUpLLUD4+zWqcDvmiUKoaLojhNImy0z3EGn/l5P7m2DAW+JprPqGJyO
         c2YNsZyRE7uiWQLaGojOAu7fp+QOEnOohoYO0v3qMipUh1NsJlmZKkEmDXw1QlAV41dI
         WCjBpYxGh/Bbqi7CMJOAp5EvV/JPEm6wIa1MRveSNzP3RdZCIHtuLc6jd0xNeZ+Pt/9e
         VEh0qa0Ad0E+emu1ewMcnZIS/txQAfDmTL78yNpj/f+hBnw6jYyO3eLkp6Vfzd0K3Jyr
         WHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWD2VhFJWDHHewwnCQjz6uRs4tdSsCXVH30fek1ho6RcaqAH98bPy0BhtFcnYdwAsRqgps8wUJJrKbO/Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89Y65PJO220aoeh1AUSRAzFb1T0KhvIohtI6lPPs9FdJYawU7
	IqoNSF8IEh4GdkdjWfZRJExyqFzs2hPsa5ypao7w2TE+t6V/95MDRxhQzAoR8wIKTH8=
X-Gm-Gg: ASbGncvQz1CF8Pj9EkfFsqX0A2AWsZfz/MllgFw66cMzyK8Qj23hXOFlHkKci6EUfy1
	dAYrzyQUDlHtbgmU+83Gi+2VmVXT8uTXMhjPk2JdWQfd4zj3weXTRRyiFDNATQNlOnsLleQ/qE8
	hxI8nRtnxou3x6reH7FE1R/DIz+ItPOWhfRMr95qE30FfRfIkO8mG/y/Pfz2e5INeatCvxOq9Ry
	83WClNVfh3z1IjU//SFXkxMRKOul5YjTjo55EEp1OyfWRfIk133NuHg9KVyxkNAOQEYRjQULdUT
	d5t+d3cevUDcWhNxRQAyES64/7UclYgZ3zIJtuugOB/GHBx9ktp3vKyvx8ry3Y1ImXuC//bp6tz
	8qs/nz+V/DTlZ1lsq7nMg4LlkJBAQqBn6nxG3C4YwVlxSMfxHzRuLwwYQyBltESu/YPYQuDluRC
	magk96h3Hn938=
X-Google-Smtp-Source: AGHT+IHqmW49ZZANvNBaNgggrQ29I6My8kl8bn5i+sILCwaQX0HxqwrEfZnSXrOqBfoDKTsomvJbOw==
X-Received: by 2002:a05:6902:2786:b0:e81:b941:c210 with SMTP id 3f1490d57ef6-e8dc5818abbmr1198612276.2.1753252735788;
        Tue, 22 Jul 2025 23:38:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:6470:8880:4432:859b:f25f:b2ca? ([2600:1700:6470:8880:4432:859b:f25f:b2ca])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc198a4sm3778895276.2.2025.07.22.23.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 23:38:55 -0700 (PDT)
Message-ID: <96e9e5b9-d7f2-4527-baf2-f7519ffbb612@gmail.com>
Date: Tue, 22 Jul 2025 23:38:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Min Ma <mamin506@gmail.com>
Subject: [PATCH] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
To: ogabbay@kernel.org, quic_jhugo@quicinc.com,
 jacek.lawrynowicz@linux.intel.com, lizhi.hou@amd.com,
 dri-devel@lists.freedesktop.org
Cc: mamin506@gmail.com, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I recently left AMD and would like to continue participating in
the review and maintenance of the XDNA driver using my personal email 
address.
This commit updates my contact information accordingly.

Signed-off-by: Min Ma <mamin506@gmail.com>
---
  MAINTAINERS | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..6eefa494000c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,7 +1231,7 @@ F:        drivers/spi/spi-amd.c
  F:     drivers/spi/spi-amd.h

  AMD XDNA DRIVER
-M:     Min Ma <min.ma@amd.com>
+M:     Min Ma <mamin506@gmail.com>
  M:     Lizhi Hou <lizhi.hou@amd.com>
  L: dri-devel@lists.freedesktop.org
  S:     Supported
--
2.43.0


