Return-Path: <linux-kernel+bounces-809207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C814B50A05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B6542291
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058331C862E;
	Wed, 10 Sep 2025 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awtvV3h0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98291C1F05
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757465639; cv=none; b=IEQ7L0/UZrTFhamPm6VLBygISqeNP8GxZI1sD0BMTqv/itCUx0sRyanz7aJKnYmcX2fAeLyLSWiK29GwuecH9AnBykbBjq20/jeXfnLripDtV9iFzApmyZP1qkEQgWABng06BZc143d0e1gJEI29GFJ/K+5ALQiUkRQaQYSTcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757465639; c=relaxed/simple;
	bh=tudW+T0dmyKp8YIE4NUhg+9r3OZ/rus55e7UFnsKP78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhdJWRW3u06xRgYB7at08fDdz6j3mEbiiKyksd1N9JAR1zM/rLS1lZ82mscr7bIFJH3xw2wqBwKc9/QhyNzsVK/nJSaqkHhc7bjX8BJZQYqEh2AVZXs9/FMkLkm1P9tC2LNGNeGX0TAG+jG1KHR8CbgglqCc+5/11b8GwTx1zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awtvV3h0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7728815e639so3404817b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757465637; x=1758070437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQyP0GZJc1hFrxmU66hajulLthQQnuqIFSCA90Eid9s=;
        b=awtvV3h0LtcJeL1W/QmVp3D5gB7//9/sev0DORxmI9FjpBBhcY7oy76Itg+rnD64ja
         yim0DuM6YDUIvQDMSRz2btIbjIWt2pKlDEI0WW/EtXA1IXbC2SOBC9sC6oABHYJfkg67
         VnAHzD9481on6uf8w+h70jWRif/HRnIVHY2YXj3GAgq2FpD6VRu7kg20bc32J1cK3eZ1
         2cTqmXCf7xT93ikVdeXF2ZsxN2V2EiPeObrZcO+wm447V0xeF3Neing7ksCRLNCXYm96
         2QsbqqtZhH1Ij3RdAkFnwulXk7mU4Cu4TFqSzlBVFt9QOLp8RhKcM5pWMCYkT+v1XjhD
         rXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757465637; x=1758070437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQyP0GZJc1hFrxmU66hajulLthQQnuqIFSCA90Eid9s=;
        b=SgZvcVUC4DE8ntli1qRF3nrVW3t9padNmINEls2R4Hx88S/R4P65Gz6XEn8UG81gC3
         dWa9OrbV09hf3JHIeBr2F0G5JG0CgWzOaVIknmJAOFLpysi/ZDnm3wHuBHqLqU3rQJt5
         Ry09mzA8vFZGFrdbnopIuYYdBVfiTsijK34NfInd43RW2rJxYrkz8LODWxHOKYEWljJD
         je3CSNgJ9oIeg4lEAfXF1F8cXeuFJONS7FDwIvkiXa/znA56lpuKGvjy21mb15C8vHgp
         x7Wmeg9loRc6Q9fWNeOaX+9jtJ4uPpWM6W5wWUUMRD/m0bok2fLRCdYmweTA39ZMdOfI
         3VnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyUB7jN2Q0PLoh6fvw7eIWn0+w4uMlJLBvZy+PrtgWME9JcVdvcgKTzKVKUEtj+O2DDD6KUYViFmC3o8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx411Fz4MnzO+fV//m5A/bkmAnLfzVAgomFFnQsbULnUOd2uEfX
	S03Kdz3CuO/2N7LatBAGNy7iKm9HpUNWGIJAaGKKun3Frp8O6BituYdl
X-Gm-Gg: ASbGncvlBreHP8v+ArGdvVoXPiBg153/sYXk8S8p3H2ctjwtS0m5jToaUPosmYUAqzm
	CtY6Io/6iAqTSXp4ixl18R6+sM26jbt2CY/4O22HH6QZpdaIX6BeFKZHZ6mNVRXdD9hQU9IRLbl
	SwdV3Ut1RVoYTOMGJMP9AyNT4Zz9g+XzJi4j6Cax5efbWiausAQ/Hn+wozUbDgCPm4rR/WcowI+
	pFq1O/NtEdhcGaBCIDYFgnD+O5/B7q3L2n7ksue6bbbJRPVVi8QOZ+fFo7vzk/OMH8QEZsFfAxx
	PH/NufEbAE2cKAaj+ZjeTtja3v/0fU9jZAVoYAIfGFUCtfIPl8DzNFmOepqCfuvqAoWvMf3ebHd
	FVI+PfgAmelE0+u8axusup9M/rLw8bNgdfBe6
X-Google-Smtp-Source: AGHT+IHAZHC7oAM8pJIFcJFqO6POsM5S1IybN/l0HMvF9MBkuhQT84W6uIqRsAsMv6iq7YsoCXx+4A==
X-Received: by 2002:a05:6a00:2ea8:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7742dce028fmr18864649b3a.8.1757465636796;
        Tue, 09 Sep 2025 17:53:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662fea7fsm3210232b3a.103.2025.09.09.17.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:53:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E65E0420A809; Wed, 10 Sep 2025 07:53:51 +0700 (WIB)
Date: Wed, 10 Sep 2025 07:53:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
Message-ID: <aMDMHx1spjeETKK4@archie.me>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-8-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-8-arbn@yandex-team.com>

On Tue, Sep 09, 2025 at 10:14:42PM +0200, Andrey Ryabinin wrote:
> +There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.

Escape the trailing underscore (i.e. KSTATE\_).

> +Addition of new field can be done as version dependent field by using _V form of
> +KSTATE_ macro:

Ditto.

> +Subsections
> +-----------
> +Another option is adding subsection to kstate_description. A subsection is
> +additional kstate_description which linked to the main one:
> +
> +struct kstate_description test_state_v2 = {
> +	.name = "test_v2",
> +	.id = KSTATE_TEST_ID_V2,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
> +		KSTATE_END_OF_LIST()
> +	},
> +};
> +
> +struct kstate_description test_state = {
> +	......
> +	.subsections = (const struct kstate_description *[]){
> +		&test_state_v2,
> +		NULL
> +	},
> +};

Sphinx errors out on struct snippets like above:

Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/core-api/kstate.rst:21: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:28: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:32: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:33: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:84: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:100: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:102: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:103: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:106: CRITICAL: Unexpected section title or transition.

...... [docutils]

reStructuredText markup error!

I have to wrap them in literal code blocks:

---- >8 ----
diff --git a/Documentation/core-api/kstate.rst b/Documentation/core-api/kstate.rst
index 981ba162109c34..620d7c126c2038 100644
--- a/Documentation/core-api/kstate.rst
+++ b/Documentation/core-api/kstate.rst
@@ -11,16 +11,16 @@ kstate_description
 ------------------
 
 Most kernel's state is in structs and structs could be described by
-kstate_description. E.g.
+kstate_description. E.g.::
 
-struct kstate_test_data {
+  struct kstate_test_data {
 	int i;
 	unsigned long *p_ulong;
 	char s[10];
 	struct folio *folio;
-};
+  };
 
-struct kstate_description test_state = {
+  struct kstate_description test_state = {
 	.name = "test",
 	.version_id = 1,
 	.id = KSTATE_TEST_ID,
@@ -30,7 +30,7 @@ struct kstate_description test_state = {
 		KSTATE_FOLIO(folio, struct kstate_test_data),
 		KSTATE_END_OF_LIST()
 	},
-};
+  };
 
 Changing data structures
 ------------------------
@@ -55,7 +55,7 @@ There are two version fields:
 
 KSTATE is able to read versions from minimum_version_id to version_id.
 
-There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
+There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.::
 
 	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
 
@@ -67,7 +67,7 @@ be loaded by any older kernel.
 Removing field
 --------------
 If field is no longer needed it could be marked deprecated using
-KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description:
+KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description::
 
 	KSTATE_BASE_TYPE_DEPRECATED(k, u16, 1),
 
@@ -80,7 +80,8 @@ Adding new field
 ----------------
 
 Addition of new field can be done as version dependent field by using _V form of
-KSTATE_ macro:
+KSTATE_ macro::
+
 	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
 
 This indicates that 'test_state' only from version 2 and above have field '->i'.
@@ -91,24 +92,24 @@ understand the new V2 'test_state'.
 Subsections
 -----------
 Another option is adding subsection to kstate_description. A subsection is
-additional kstate_description which linked to the main one:
+additional kstate_description which linked to the main one::
 
-struct kstate_description test_state_v2 = {
+  struct kstate_description test_state_v2 = {
 	.name = "test_v2",
 	.id = KSTATE_TEST_ID_V2,
 	.fields = (const struct kstate_field[]) {
 		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
 		KSTATE_END_OF_LIST()
 	},
-};
+  };
 
-struct kstate_description test_state = {
+  struct kstate_description test_state = {
 	......
 	.subsections = (const struct kstate_description *[]){
 		&test_state_v2,
 		NULL
 	},
-};
+  };
 
 
 Subsection must have a unique ->id. If the receiving side finds a subsection

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

