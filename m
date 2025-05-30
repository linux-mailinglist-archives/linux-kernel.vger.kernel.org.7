Return-Path: <linux-kernel+bounces-667633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76243AC879A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 06:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94343ABF32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B8D1F0992;
	Fri, 30 May 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qxK5LkC2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F601F4191
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580667; cv=none; b=EXqANMkKtA2WhCE9sB9q7cZ02BQ6t5sNgnwR2bPaoqo7+/CPEzLkz10laP7xGCVn2TRV5IhIqXZ0VK3b96NQTi1PiQI58NyVgfJy5cI2oNVwImFFTQsDjZquKZgRGnx6g+k0DMTH3TUQSlED/ERWhfBOTTG6vR498/GgI5ctx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580667; c=relaxed/simple;
	bh=8QZ3Y17huIwvFuKYxGqjjNV9gzRi3SV/EMTE+e4j/s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bNRmxMWKZQeszhalMLSMIRBuv6NUILVKcaCR8dP4MGgZI0qYRo3fwwVa+Kx8p8E+VNaor3lXfZ7YVeTWrZU3gKbrK6AQXs+S7j5RAz17dgsI0pFMLT2kM7MzWowcz3jA85xszmzww0/eATBu/cKdKAmBS9vnRtRmXY/Nal+YHNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qxK5LkC2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74019695377so985397b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580665; x=1749185465; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kg49tLaS0z1IHYonGafIguL3mgiSEk4xR/nFylD2io=;
        b=qxK5LkC2DVB0dYvE/5pN+icN9wP4bhzrrBuDTB69R2C0vaEqqECOq08QDZZdixunwy
         ravpjfFDJsy0E9EXEezXCMzeISk1PXqmD78evKIkZgildwI6t7XrYoXG1KGGM6FUBQcR
         2Td1OlJGf+YKouksaSeFP/kYW4rUFoWKy+AKRxU/+7U7/c6nVp1/ZKCcF0fiUJQfBNmj
         +UWyOXN1/oVXIn11kiEmFie8JOUFJ1p+x/+kYhJLtRPnFKtLOddyRQ/5m1489PvhzeCj
         c6PemcxaIzKBn4Hla9hhHmS7AfLmmNSDWiHc8NCTcOA3H8MPx1/fIkFdZgz4SB6rQain
         tyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580665; x=1749185465;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kg49tLaS0z1IHYonGafIguL3mgiSEk4xR/nFylD2io=;
        b=JgWgJiHQXJd+kJmWoVWalnWi62dt7Wn55/ViuhvBna2E6a9Ngh72xkqHWYh0JQO+x9
         AYHDoyCV9K616NYu5b34P2Cn/lnhkf/NNKK0FZECjEOu8W7s+4dDWLXKwH2c4YIt2GMQ
         WRMYmlgKJ+TNpOdqhIt1/5Aqu63Et7yJUoR1IdgdexGJ1yKscS/JidatdbnWxevqZE47
         FW1JdYH8ExpDte3ghekKBpV05uScWcKcDfv85If5nQamCo02RC7nYRin08Dg7T7rp2oq
         NgR9nBXeTTL/76E+VGGzAPsl9MZpW+JrQ16facxW/GGwmJz5AVxT9Uzwp6IL0UmdZ+PP
         VMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Za2V/uMl8EBrAF0G+07hObGQ7naOSJ9DikDHvIZM/riaD/JiO/GzNjHAML1V6+oT118X9Ir4aIrhxfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtTyM+vt6/zKFgm8Brmz214SH2DcBbdpenQrSRbvGmYVxqg5P
	whKkH5KB1tqZ1PPhxnH/mpNFABC/wx6TwL/kzibIFfGtefYg5IuDpJ4VZW0/96gKfNk=
X-Gm-Gg: ASbGncse/mSKwD39wpI73zjZpBdiH4bGvdNFLUYO0AUXkE9ST9IXJwQ8wx0OQ0Nu6Ez
	gMrUMXHZkkwCMrJFSueK6cl3qoKMC1gnMydVfma80wCnNoTgFSz0b46TpRa7bofjppTv2lwYloK
	+3+v3lL5PZnua9+DsQMkLsyaMxnPp6AZ/KSOSY3Y6IkG8rIMTXKIASKtuNQhyyMXIbo6OUEeaRa
	4+WuZiBbCLAZ0H8Jaz7F4c9B4HCDmY2aEL7swlO9cO75RobKGv6JsORX32CbfRWp5CNWWBWaYp1
	n9uLX20/rYJ28Fzlw1ZvIV29ZV1v2dUz7lgUmH9KOnFjOQFAUrc3rPGrCl61IlQ=
X-Google-Smtp-Source: AGHT+IH9+BHJNIoXbgVGyUoI7SrCOCtJTbLtcbCTAW+31fagg/7EMzO3Z6Fm63/CoKEr+0ydoICMHQ==
X-Received: by 2002:a05:6a00:2389:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-747bda192e1mr2706018b3a.21.1748580664899;
        Thu, 29 May 2025 21:51:04 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-747afff71eesm2159761b3a.159.2025.05.29.21.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:51:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:13 +0900
Subject: [PATCH net-next v12 09/10] selftest: tap: Add tests for virtio-net
 ioctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-9-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

They only test the ioctls are wired up to the implementation common with
tun as it is already tested for tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/config |   1 +
 tools/testing/selftests/net/tap.c  | 131 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 61e5116987f3..00cb1e65b392 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -99,6 +99,7 @@ CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
 CONFIG_TUN=y
+CONFIG_TUN_VNET_CROSS_LE=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..0decbc338965 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -387,9 +387,6 @@ FIXTURE_TEARDOWN(tap)
 	if (self->fd != -1)
 		close(self->fd);
 
-	ret = dev_delete(param_dev_tap_name);
-	EXPECT_EQ(ret, 0);
-
 	ret = dev_delete(param_dev_dummy_name);
 	EXPECT_EQ(ret, 0);
 }
@@ -431,4 +428,132 @@ TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(tap, test_vnethdrsz)
+{
+	int sz = sizeof(struct virtio_net_hdr_v1_hash);
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETHDRSZ, &sz));
+	sz = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETHDRSZ, &sz));
+	EXPECT_EQ(sizeof(struct virtio_net_hdr_v1_hash), sz);
+}
+
+TEST_F(tap, test_vnetle)
+{
+	int le = 1;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETLE, &le));
+	le = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETLE, &le));
+	EXPECT_EQ(1, le);
+}
+
+TEST_F(tap, test_vnetbe)
+{
+	int be = 1;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ret = ioctl(self->fd, TUNSETVNETBE, &be);
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNSETVNETBE not supported");
+
+	ASSERT_FALSE(ret);
+	be = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETBE, &be));
+	EXPECT_EQ(1, be);
+}
+
+TEST_F(tap, test_getvnethashtypes)
+{
+	uint32_t hash_types;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ret = ioctl(self->fd, TUNGETVNETHASHTYPES, &hash_types);
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNGETVNETHASHTYPES not supported");
+
+	EXPECT_FALSE(ret);
+}
+
+FIXTURE(tap_setvnethash)
+{
+	int fd;
+};
+
+FIXTURE_VARIANT(tap_setvnethash)
+{
+	unsigned int cmd;
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, reportingautomq)
+{
+	.cmd = TUNSETVNETREPORTINGAUTOMQ
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, reportingrss)
+{
+	.cmd = TUNSETVNETREPORTINGRSS
+};
+
+FIXTURE_VARIANT_ADD(tap_setvnethash, rss)
+{
+	.cmd = TUNSETVNETRSS
+};
+
+FIXTURE_SETUP(tap_setvnethash)
+{
+	int ret;
+
+	ret = dev_create(param_dev_dummy_name, "dummy", NULL, NULL);
+	ASSERT_FALSE(ret);
+
+	ret = dev_create(param_dev_tap_name, "macvtap", macvtap_fill_rtattr,
+			 NULL);
+	ASSERT_FALSE(ret)
+		EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+
+	self->fd = opentap(param_dev_tap_name);
+	ASSERT_LT(0, self->fd)
+		EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+}
+
+FIXTURE_TEARDOWN(tap_setvnethash)
+{
+	EXPECT_FALSE(close(self->fd));
+	EXPECT_FALSE(dev_delete(param_dev_dummy_name));
+}
+
+TEST_F(tap_setvnethash, test_alive)
+{
+	struct tun_vnet_rss rss = { .hash_types = 0 };
+	int ret;
+
+	ret = ioctl(self->fd, variant->cmd, &rss);
+
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "not supported");
+
+	EXPECT_FALSE(ret);
+}
+
+TEST_F(tap_setvnethash, test_deleted)
+{
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+
+	ASSERT_EQ(-1, ioctl(self->fd, variant->cmd));
+
+	if (errno == EINVAL)
+		SKIP(return, "not supported");
+
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.49.0


