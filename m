Return-Path: <linux-kernel+bounces-834193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0466BA4298
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3567BA5D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9852FFDFE;
	Fri, 26 Sep 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgK3iC40"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B811B5EC8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896412; cv=none; b=VbttjGrMIe5f3OShmh9FuGF8E8ZWewpX+/uu/7jggMJxj/rCAauVyORu2o8++pbpIfqc4ZO/ONyyBdNgdqqXUS/tfbcC6h3GS01uy1pBwYhOQcLdsRWsAOjFjIVs4PslXBA+jr8xS4M7yULpbJ8ArX6jgYN1FZCWRDxPLWeWqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896412; c=relaxed/simple;
	bh=PPiN8pq1LdwYIaUYStL8/OXBtkNaRwfRrT8tXpg2uJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osA6EKG/8R7EbPBDzQ+4KsdDAOTDPRg0d40+yDzyu/yqsrDVgDQawxAnonju0JcYLH5lI/gl23fIebvKPzsTP3GQ+ygMqdMf+rUEphMwV/31c+pPRhrOPTTZEA3rKTpQVEgnRAvtael+GqOLXyLbDOF5Fck4Aw4DNNbq08m5T5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgK3iC40; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FZkVHZZVz949SgHPOq8NTiY1Q1JoUahrY4S3yaDuUdI=;
	b=CgK3iC40gXnChyQ2WsUioEwU3vGia2X9byJXCywCA+tWqgJvE5zm+f3KVOOzQ9KJ3MmewP
	7beaejJlt/sFVSbeGf+KCshaqOPKKLRIj+6+RnQfRo+RBXxOaM1UIdsgsqu9pjpFMhB+1F
	GPek1nOKut6fZYVCCq7vTyAeQevOMoQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-D6_-F7m8NpCF8nW-yHeeVQ-1; Fri,
 26 Sep 2025 10:20:07 -0400
X-MC-Unique: D6_-F7m8NpCF8nW-yHeeVQ-1
X-Mimecast-MFC-AGG-ID: D6_-F7m8NpCF8nW-yHeeVQ_1758896406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEDB8180028E;
	Fri, 26 Sep 2025 14:20:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C8AB19560AB;
	Fri, 26 Sep 2025 14:20:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: 
Cc: David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Stephan Mueller <smueller@chronox.de>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] crypto, lib/crypto: Add SHAKE128/256 support and move SHA3 to lib/crypto
Date: Fri, 26 Sep 2025 15:19:43 +0100
Message-ID: <20250926141959.1272455-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Eric, Herbert,

Here's a set of patches does the following:

 (1) Renames s390 and arm64 sha3_* functions to avoid name collisions.

 (2) Copies the core of SHA3 support from crypto/ to lib/crypto/.

 (3) Simplifies the internal code to maintain the buffer in little endian
     form, thereby simplifying the update and extraction code which don't
     then need to worry about this.  Instead, the state buffer is
     byteswapped before and after.

 (4) Moves the Iota transform into the function with the rest of the
     transforms.

 (5) Adds SHAKE128 and SHAKE256 support (needed for ML-DSA).

 (6) Adds a kunit test for SHA3 in lib/crypto/tests/.

 (7) Adds proper API documentation for SHA3.

 (8) Makes crypto/sha3_generic.c use lib/crypto/sha3.  This necessitates a
     slight enlargement of the context buffers which might affect optimised
     assembly/hardware drivers.

Note that only the generic code is moved across; the asm-optimised stuff is
not touched as I'm not familiar with that.

I have done what Eric required and made a separate wrapper struct and set
of wrapper functions for each algorithm, though I think this is excessively
bureaucratic as this multiplies the API load by 7 (and maybe 9 in the
future[*]).

[*] The Kyber algorithm also uses CSHAKE variants in the SHA3 family - and
    NIST mentions some other variants too.

This does, however, cause a problem for what I need to do as the ML-DSA
prehash is dynamically selectable by certificate OID, so I have to add
SHAKE128/256 support to the crypto shash API too - though hopefully it will
only require an output of 16 or 32 bytes respectively for the prehash case
and won't require multiple squeezing.

This is based on Eric's libcrypto-next branch.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-pqc

David

Changes
=======
ver #3)
 - Renamed conflicting arm64 functions.
 - Made a separate wrapper API for each algorithm in the family.
 - Removed sha3_init(), sha3_reinit() and sha3_final().
 - Removed sha3_ctx::digest_size.
 - Renamed sha3_ctx::partial to sha3_ctx::absorb_offset.
 - Refer to the output of SHAKE* as "output" not "digest".
 - Moved the Iota transform into the one-round function.
 - Made sha3_update() warn if called after sha3_squeeze().
 - Simplified the module-load test to not do update after squeeze.
 - Added Return: and Context: kdoc statements and expanded the kdoc
   headers.
 - Added an API description document.
 - Overhauled the kunit tests.
   - Only have one kunit test.
   - Only call the general hash tester on one algo.
   - Add separate simple cursory checks for the other algos.
   - Add resqueezing tests.
   - Add some NIST example tests.
 - Changed crypto/sha3_generic to use this
 - Added SHAKE128/256 to crypto/sha3_generic and crypto/testmgr
 - Folded struct sha3_state into struct sha3_ctx.

ver #2)
  - Simplify the endianness handling.
  - Rename sha3_final() to sha3_squeeze() and don't clear the context at the
    end as it's permitted to continue calling sha3_final() to extract
    continuations of the digest (needed by ML-DSA).
  - Don't reapply the end marker to the hash state in continuation
    sha3_squeeze() unless sha3_update() gets called again (needed by
    ML-DSA).
  - Give sha3_squeeze() the amount of digest to produce as a parameter
    rather than using ctx->digest_size and don't return the amount digested.
  - Reimplement sha3_final() as a wrapper around sha3_squeeze() that
    extracts ctx->digest_size amount of digest and then zeroes out the
    context.  The latter is necessary to avoid upsetting
    hash-test-template.h.
  - Provide a sha3_reinit() function to clear the state, but to leave the
    parameters that indicate the hash properties unaffected, allowing for
    reuse.
  - Provide a sha3_set_digestsize() function to change the size of the
    digest to be extracted by sha3_final().  sha3_squeeze() takes a
    parameter for this instead.
  - Don't pass the digest size as a parameter to shake128/256_init() but
    rather default to 128/256 bits as per the function name.
  - Provide a sha3_clear() function to zero out the context.

David Howells (8):
  s390/sha3: Rename conflicting functions
  arm64/sha3: Rename conflicting functions
  lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA-512, SHAKE128,
    SHAKE256
  lib/crypto: Move the SHA3 Iota transform into the single round
    function
  lib/crypto: Add SHA3 kunit tests
  crypto/sha3: Use lib/crypto/sha3
  crypto/sha3: Add SHAKE128/256 support
  crypto: SHAKE tests

 Documentation/crypto/index.rst      |   1 +
 Documentation/crypto/sha3.rst       | 241 +++++++++++++
 arch/arm64/crypto/sha3-ce-glue.c    |  47 +--
 arch/s390/crypto/sha3_256_s390.c    |  26 +-
 arch/s390/crypto/sha3_512_s390.c    |  26 +-
 crypto/sha3_generic.c               | 233 +++---------
 crypto/testmgr.c                    |  14 +
 crypto/testmgr.h                    |  59 ++++
 include/crypto/sha3.h               | 467 +++++++++++++++++++++++-
 lib/crypto/Kconfig                  |   7 +
 lib/crypto/Makefile                 |   6 +
 lib/crypto/sha3.c                   | 529 ++++++++++++++++++++++++++++
 lib/crypto/tests/Kconfig            |  12 +
 lib/crypto/tests/Makefile           |   1 +
 lib/crypto/tests/sha3_kunit.c       | 338 ++++++++++++++++++
 lib/crypto/tests/sha3_testvecs.h    | 231 ++++++++++++
 scripts/crypto/gen-hash-testvecs.py |   8 +-
 17 files changed, 2012 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/crypto/sha3.rst
 create mode 100644 lib/crypto/sha3.c
 create mode 100644 lib/crypto/tests/sha3_kunit.c
 create mode 100644 lib/crypto/tests/sha3_testvecs.h


