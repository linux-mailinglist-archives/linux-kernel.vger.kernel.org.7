Return-Path: <linux-kernel+bounces-754164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D17B18F2A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379C1189AC15
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494423F295;
	Sat,  2 Aug 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWp6+N8r"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8E15C158
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754146569; cv=none; b=EU4UynrxDWl9tfUq0EbNFsgDVl+QzYOyxg4Y0af9VrQVwnfzgUi7McTNtQ/s+qHSCp4Z3YYR+4+XVGCV0q1Q14FrBlxmL22oTDzDOqp4zMa/Xp/9OeTBzNhRR0+xCN0jyMAhCKa4jgM6wgl12cQAGlh1IIH9eX5L0tyT9FILWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754146569; c=relaxed/simple;
	bh=VFIQDx9jML9SEN8VHLNX4OPnIHGjH/nFv4ZQNimXz4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OhG2NhuWO/5w3nx9jKy2VQFzwcBCOgbfLoDk2KtPfzx6mRMsxb/0gt4Q3VsdCYVycMNecGOoeuqCRjqQxmLVLKRI4NOBUBWB8Cchq0E+YBM3i90fOMPZAshllf9oSbNM9FIRtNA/OuNgH+lLrvEdgZ9fXciK0z8SmGOCNEfIuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWp6+N8r; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-33250b6be11so10159621fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754146566; x=1754751366; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5/WcfyLTnspOzwu70PcmYPi8Bx5L5ceVWUInxE8s26U=;
        b=NWp6+N8rVuleiqnADq3nHgwElRmb6dmI4pIOAntbe/8Ih3xfnKoRzd1Qdd5TgVyDbk
         gKdJFT033M9I2Ic+izCCfXsstfcqHhpYDmQcPzbBg5kiFJuYhNRKO/W5FmMn+Kf9Yr5J
         qi1GW61ShyTnz+8doRK62EmvSt+d/e7ZeZt3lwt6FX0Md7J/pxWr1jm3/NSrisxfMA9N
         MPKpN5h4jT8GBrmARvRmhBVWFJdSLMIksVedkAobaoePUyyiNK1B3Nhiwx4PXT/6UCi6
         abt1L+6pJ0k2/RuuZA9oz7tYT3yOPX3dupNzFhS1fAbwhoJdDJfAcho9P+kcQAbRRJHs
         L6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754146566; x=1754751366;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/WcfyLTnspOzwu70PcmYPi8Bx5L5ceVWUInxE8s26U=;
        b=RlMaBOrOprMxXVwfCJb0gMF+86sghu+B2nfPhnuEt3S29exBmUR+BGDiekKjMqMMvm
         yBgV1SfM6jiD83tl88SNlZY8MDnb7a0ggQd4od9Ub65tSnLsDVUTZ52rzdF+6GVkQjR7
         Bqbu55sa0cd7gKbdT8A7hnali4E6sdeqJ/q6YVuMdrx1AywcgMOiBX3UNwOs4vn73i/C
         5wtVHkuUx+vKKGmY612IR9Ld7cIDxXqv2uGhjya4UGztI0bZQZJNolC3bTWWEGANVHr0
         1SB7Vpj/FCDPFJMbOhD9p7OxiHio8uJP7qe6p9PiigEuP+7yv+GF+CrB3Ka8JjGJZDeW
         Kekw==
X-Gm-Message-State: AOJu0YzNirbpRXGvILrM0pJireatlInFQJEDy2aiiH47iGqYtFzWcFQt
	yIg4qT5p6f3njsiqoViHx00Sau5jgz+EMM/MFVIx6T7oHoFryKWNh9Y01Tp902Ut7hfAPzYLEpS
	cQfK+YyKG3+Fl1yXyozHINvj5dMfmiJYp8UZ3ygA=
X-Gm-Gg: ASbGncsCvXhQUWV0xZhprRu7XUZvqOSU0QvlW6JyfnM28ag2PHmThawvMvcJrcYTlSa
	A1d9LjLpgQe5pkXkjZCCIKYZr3jOwgvdhztRuf08KC31V4/t98hlweAeJPNvei90tReJXiz8Bwf
	ZzXQNDuZrna81Y0F/3V/AKGh8yPkeXEmZVFQn9RctH+g1i4C7Ho2h1YTz42SKHOU7B69glBQzrI
	c6g8Yo=
X-Google-Smtp-Source: AGHT+IH4Jet1/AdFn9/kNIXugZftK8+vhYQmiCkZcPfi9+RBqUxK0r0NHm9kBaVPYrjaIvHRGLXU7v2eAxrw+iawr+s=
X-Received: by 2002:a2e:a98f:0:b0:332:5af9:7208 with SMTP id
 38308e7fff4ca-3325af97837mr4926611fa.16.1754146565514; Sat, 02 Aug 2025
 07:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jakub Godula <kuubbaa2@gmail.com>
Date: Sat, 2 Aug 2025 16:55:54 +0200
X-Gm-Features: Ac12FXy0dOFiosWWB7iZv88K-lV-KMVrxcF2SLgu9v-SceUnxD5CItIPKLha0dQ
Message-ID: <CA+HWTtBQ1nxLK0oO6MSe80vgPgAD3aVchjXqVpg-SrLDmiG7qw@mail.gmail.com>
Subject: [RFC] Proposal: Distributed Kernel Identity Management via Algorand
 (PQC + ZK Proofs)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernel maintainers and community,

I would like to propose a new kernel feature: a blockchain-integrated
identity framework for users, services, and system entities,
leveraging the Algorand blockchain for its post-quantum cryptography
(PQC) capabilities and native support for zero-knowledge (ZK) proofs.
The aim is to introduce a distributed, tamper-resistant identity and
key management layer into the Linux kernel, inspired by the integrated
identity approach found in Harmony OS, while providing stronger
guarantees against future cryptographic threats.

Motivation and Problem Statement:
Current Linux identity and key management mechanisms (local keyrings,
PKI, external integration with LDAP/Kerberos) are robust but
inherently centralized or rely on third-party services. As scenarios
around distributed systems, edge devices, and secure IoT deployments
grow, there is demand for a built-in, decentralized mechanism that:

    Prevents single points of trust or compromise;

    Is resistant to next-generation (quantum) attacks;

    Facilitates secure, user-controllable key storage and management
at kernel level;

    Enables privacy-preserving authentication and access control
(using ZK proofs).

Proposed Solution:
Integrate an optional kernel subsystem that allows user and service
identities (and their keys) to be registered and/or validated via
either public or private blockchains. The default implementation would
use Algorand for its PQC primitives and support for efficient ZK
proofs, but the architecture would be designed to support other
blockchains as well. To allow identities from any other blockchain,
the module would strictly require that those blockchains provide both
PQC and ZK proofs for identity validation and authentication, ensuring
any integrated identity meets the highest standards for security and
privacy, even in cross-chain scenarios.

This would allow:

    The kernel to validate user/service identities and keys in a
trustless, distributed fashion;

    Support for cryptographically-strong, privacy-aware authentication
flows using ZK proofs, lowering the risk and exposure of key material
and metadata;

    A foundation for cross-device, cross-OS identity portability,
similar to Harmony OS but within the Linux ecosystem.

    Filesystem integration: Filesystems can make use of user/service
keys stored on Algorand (or another qualified blockchain) for access
control, encryption, and secure data sharing.

    Hardened module policy: Identities from other blockchains are only
permitted if those blockchains can deliver PQC-secured,
ZK-proof-verified identity material to the kernel.

Expanded Use Cases:

    Dynamic, Fine-Grained Data Sharing: Controlled sharing of data
streams (camera feeds, etc.) in on-chain organizations.

    Remote Control of Registered Devices: Unified, authenticated
control of devices registered to a user across ecosystems, secured and
audited on-chain.

    Enhanced Security and Detection: All inter-node communication is
zero-trust and ZK-proofed, minimizing compromise risks and increasing
anomaly detection.

    Distributed IdP (Identity Provider) Community: Enables federated,
rootless trust through distributed identity providers.

    Flexible Blockchain Backend: System can work with either public or
private blockchains as long as PQC and ZK requirements are satisfied.

Design Considerations:

    The subsystem is optional and modular.

    Minimal performance impact due to efficient proof validation and
intelligent caching.

    Failsafe modes and compatibility with classic Linux identity systems.

    Security: No privilege boundary weaknesses; privacy: ZK proofs
protect identity and key data from unnecessary disclosure.

    Interfaces for integration with various kernel components
(filesystems, device management, user/session management).

Potential Use Cases:

    Multi-device credentials, portable and auditably secure.

    IoT/edge identity autonomy.

    Filesystem-level encryption and access control using blockchain-based keys.

    Device fleet control with unified, on-chain identity management.

Request for Comments:
I am seeking feedback on feasibility, integration points (keyring,
LSM, PAM, filesystems, device management), interest among maintainers,
and architecture for multi-blockchain extensibility and policy
enforcement regarding PQC and ZK proofs. A preliminary prototype and
documentation will follow.

Thank you for your consideration and I look forward to your thoughts.

Best regards,

Jakub Godula

