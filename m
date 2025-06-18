Return-Path: <linux-kernel+bounces-691519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C6ADE5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B681885706
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E227FB05;
	Wed, 18 Jun 2025 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GF4F+FLd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AC20D509;
	Wed, 18 Jun 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235615; cv=none; b=sfpK0HV+d0pITxt0IMatGsVhEGCDZp41a3/vHjIjQfzTPbzi0CcdtyGm68yWduqCep2jL8gyQoZlsQQyhYphDVKqXashsklYw50YRD7fDyJYgOh3l4yrfWVfwdsc9JmWygPjmKEJkNXN0n5T5lcwBm4k65qtLqMBxSC9WRrg+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235615; c=relaxed/simple;
	bh=4WOUV4MiCmkNPRrnzISkMX/z2sYZ0elWql9xmBheIIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcyWYZXYHH2iASN94P7hkGZ14v1nfaFiL+pBxNGvarhkASONP4O2YhDZqFSaqqg0x0PZkowuAJ18KvFoZ0uxSgUAi4jBXiS5z2IV8DFkJn3XF58Cc5g5c28dZ6fofzXRzgF2kR/Dm3nd/gQhLfooYAjBJEhNjNs11EaHckRC3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GF4F+FLd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750235612; x=1781771612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4WOUV4MiCmkNPRrnzISkMX/z2sYZ0elWql9xmBheIIM=;
  b=GF4F+FLdii/dZRD4iJBEZZGa48tvFeJtTaUcOvMc10zwGFJwXFKw19VB
   Q1j3V1BNX6VN8gPma28yfKg2tWWvrLIFrVASfdJh+QVLNuKquz7BM1JuI
   Gj8k5Wk1UKVV1H1AW3yKp2HARG6laPQM3uGnDdkH54KTIs472P2eosCFd
   Y51lg42WV5ECYYmM9nfY8LCHdy1gpWmdyK8cJBr6Glk1pbpzRS57Zgn7K
   P6NVGLHBsULo6aGtyeQ6i4th7+7DbURYrMTKw1O6hAQcWvHAMCDkY+kc2
   CLCmAK2YOd4jp5KlPa8Z1SEzYfzzSloPES9ltk+gmRub2V4uu0+846Mz2
   g==;
X-CSE-ConnectionGUID: 7n6g1HsgQR+o0WSXWWSFyA==
X-CSE-MsgGUID: fgqQTI1/RgCq6hw5etw4sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63048774"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63048774"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:33:30 -0700
X-CSE-ConnectionGUID: u7eOU9WpSeSXwH7hlyyFzg==
X-CSE-MsgGUID: o+wYy/iWTTys2JZtPih+HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149988022"
Received: from mmowka-mobl.ger.corp.intel.com (HELO [10.245.101.212]) ([10.245.101.212])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 01:33:23 -0700
Message-ID: <8540352d-a7e3-4697-bc8f-2345e674548c@linux.intel.com>
Date: Wed, 18 Jun 2025 10:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/19] Documentation/x86: Secure Launch kernel
 documentation
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-2-ross.philipson@oracle.com>
Content-Language: pl
From: "Mowka, Mateusz" <mateusz.mowka@linux.intel.com>
In-Reply-To: <20250421162712.77452-2-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21-Apr-25 6:26 PM, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> Introduce background, overview and configuration/ABI information
> for the Secure Launch kernel feature.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Mateusz Mowka <mateusz.mowka@linux.intel.com>

> ---
>   Documentation/security/index.rst              |   1 +
>   .../security/launch-integrity/index.rst       |  11 +
>   .../security/launch-integrity/principles.rst  | 308 +++++++++
>   .../secure_launch_details.rst                 | 587 ++++++++++++++++++
>   .../secure_launch_overview.rst                | 240 +++++++
>   5 files changed, 1147 insertions(+)
>   create mode 100644 Documentation/security/launch-integrity/index.rst
>   create mode 100644 Documentation/security/launch-integrity/principles.rst
>   create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>   create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
>
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 3e0a7114a862..f89741271ed0 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -20,3 +20,4 @@ Security Documentation
>      landlock
>      secrets/index
>      ipe
> +   launch-integrity/index
> diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
> new file mode 100644
> index 000000000000..838328186dd2
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/index.rst
> @@ -0,0 +1,11 @@
> +=====================================
> +System Launch Integrity documentation
> +=====================================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   principles
> +   secure_launch_overview
> +   secure_launch_details
> +
> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
> new file mode 100644
> index 000000000000..91270ba25831
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/principles.rst
> @@ -0,0 +1,308 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +=======================
> +System Launch Integrity
> +=======================
> +
> +:Author: Daniel P. Smith
> +:Date: March 2025
> +
> +This document serves to establish a common understanding of what a system
> +launch is, the integrity concern for system launch, and why using a Root of Trust
> +(RoT) from a Dynamic Launch may be desirable. Throughout this document,
> +terminology from the Trusted Computing Group (TCG) and National Institute for
> +Standards and Technology (NIST) is used to ensure that a vendor natural language
> +describes and references security-related concepts.
> +
> +System Launch
> +=============
> +
> +There is a tendency to consider the classical power-on boot as the only means to
> +launch an Operating System (OS) on a computer. In fact, driven by the
> +Trusted Computing Group (TCG) architecture, modern processors can support
> +two methods of system launch: Static Launch and Dynamic Launch.
> +
> +Static Launch
> +-------------
> +
> +Static launch is the system launch associated with the power cycle of the CPU.
> +Thus, static launch refers to the classical power-on boot where the
> +initialization event is the release of the CPU from reset and the system
> +firmware is the software payload that brings the system up to a running state.
> +Since static launch is the system launch associated with the beginning of the
> +power lifecycle of a system, it is therefore a fixed, one-time system launch.
> +It is because of this that static launch is referred to and thought of as being
> +"static".
> +
> +Dynamic Launch
> +--------------
> +
> +Modern CPU architectures provide a mechanism to re-initialize the system to a
> +"known good" state without requiring a power event. This re-initialization is the
> +starting point for a dynamic launch and is referred to as The Dynamic Launch Event
> +(DLE). The DLE functions by accepting a software payload, referred
> +to as the Dynamic Configuration Environment (DCE), that execution is handed to
> +after the DLE is invoked. The DCE is responsible for bringing the system back
> +to a running state. Since the dynamic launch is not tied to a power event like
> +static launch, this enables a dynamic launch to be initiated at any time
> +and multiple times during a single power life cycle. This dynamism is the
> +reasoning behind referring to this system launch as "dynamic".
> +
> +Because a dynamic launch can be conducted at any time during a single power
> +life cycle, it is classified as either one of two types: an early launch or a
> +late launch.
> +
> +:Early Launch: A dynamic launch that is used as a transition from a static
> +   launch chain to the final Operating System.
> +
> +:Late Launch: A dynamic launch by an executing Operating System to
> +   transition to a "known good" state to perform one or more operations, e.g. to
> +   launch into a new Operating System.
> +
> +System Integrity
> +================
> +
> +For software systems, there are two system states for which the integrity of the
> +software is critical: when it is loaded into memory and when it is executing on the
> +hardware. Ensuring that the expected software is loaded into memory is referred to
> +as load-time integrity. Ensuring that the software executing is the expected
> +payload is the runtime integrity of that software.
> +
> +Load-time Integrity
> +-------------------
> +
> +Load-time integrity is when a trusted entity, i.e. an entity with an assumed
> +integrity, takes an action to assess an entity being loaded into memory before
> +it is used. A variety of mechanisms may be used to conduct the assessment, each
> +with different properties. A particular property is whether the mechanism creates
> +evidence of the assessment. Often either cryptographic signature checking or
> +hashing are the common assessment operations used.
> +
> +A signature checking assessment functions by requiring a representation of the
> +accepted authorities and uses those representations to assess if the entity has
> +been signed by an accepted authority. The benefit of this process is that it
> +includes an adjudication of the assessment. The drawbacks are that 1) the adjudication
> +is susceptible to tampering by the Trusted Computing Base (TCB), 2) there is no
> +evidence to assert that an untampered adjudication was completed, and 3) the system
> +must be an active participant in the key management infrastructure.
> +
> +A cryptographic measurement does not adjudicate the assessment, but
> +instead generates evidence of the assessment to be adjudicated independently.
> +The benefit to this approach is that the assessment may be simplified such that it
> +can be implemented in an immutable mechanism, e.g. in hardware.  Additionally,
> +it is possible for the adjudication to be conducted where it cannot be tampered
> +with by the TCB. The drawback is that a compromised environment will be allowed
> +to execute until an adjudication can be completed.
> +
> +Ultimately, load-time integrity provides confidence that the correct entity was
> +loaded and in the absence of a run-time integrity mechanism assumes, i.e.
> +trusts, that the entity will never become corrupted.
> +
> +Runtime Integrity
> +-----------------
> +
> +Runtime integrity, in the general sense, is when a trusted entity makes an
> +assessment of another entity at any point in time during the assessed entity's
> +execution. A more concrete explanation is the taking of an integrity assessment
> +of an active process executing on the system at any point during the process'
> +execution. Often the load-time integrity of an operating system's user-space,
> +i.e. the operating environment, is confused with the runtime integrity of the
> +system, since it is an integrity assessment of the "runtime" software. The
> +reality is that actual runtime integrity is a very difficult problem and thus
> +not very many solutions are public and/or available. One example of a runtime
> +integrity solution would be Johns Hopkins Advanced Physics Laboratory's (APL)
> +Linux Kernel Integrity Module (LKIM).
> +
> +Trust Chains
> +============
> +
> +Building upon the understanding of security mechanisms to establish load-time
> +integrity of an entity, it is possible to chain together load-time integrity
> +assessments to establish the integrity of the whole system. The process of
> +creating this chain involves using a series of transitive trust assertions to
> +establish confidence in the load-time integrity of each component loaded.
> +
> +This process is known as transitive trust and provides the concept of building
> +a chain of load-time integrity assessments, commonly referred to as a trust
> +chain. These assessments may be used to adjudicate the load-time integrity of
> +the whole system. This trust chain is started by a trusted entity that does the
> +first assessment. This first entity is referred to as the Root of Trust (RoT)
> +with the entity's name being derived from the mechanism used for the assessment,
> +i.e. RoT for Verification (RTV) and RoT for Measurement (RTM).
> +
> +A trust chain is itself a mechanism, specifically a mechanism of mechanisms,
> +and therefore, it also has a Strength of Mechanism. The factors that contribute
> +to the strength of a trust chain are:
> +
> +  - The strength of the chain's RoT
> +  - The strength of each member of the trust chain
> +  - The length (i.e. the number of members) of the chain
> +
> +Therefore, the strongest trust chains should start with a strong RoT,
> +consist of members being of low complexity, and minimize the number of members
> +participating. In a more colloquial sense, a trust chain is only as strong as its
> +weakest link, therefore more links increase the probability of a weak link.
> +
> +Dynamic Launch Components
> +=========================
> +
> +The TCG architecture for dynamic launch is composed of a component series
> +used to set up and then carry out the launch. These components work together to
> +construct an RTM trust chain rooted in the dynamic launch, commonly
> +referred to as the Dynamic Root of Trust for Measurement (DRTM) chain.
> +
> +.. note::
> +    Intel TXT pre-dates the TCG Dynamic Launch specification. In the Intel TXT
> +    documentation, Dynamic Root of Trust for Measurement was abbreviated as DRTM.
> +    When Dynamic Launch was codified in the TCG specification, it was given
> +    the acronym D-RTM. There is a similar situation with Static Root of Trust for
> +    Measurement. In TCG documentation it will be given the acronym S-RTM but it is not
> +    uncommon to see it as SRTM. For the purposes of the launch integrity documents,
> +    DRTM and SRTM will be the preferred acronym.
> +
> +What follows is a brief explanation of each component in execution order. A
> +subset of these components is what establishes the dynamic launch's trust
> +chain.
> +
> +Dynamic Configuration Environment Preamble
> +------------------------------------------
> +
> +The Dynamic Configuration Environment (DCE) Preamble is responsible for setting
> +up the system environment in preparation for a dynamic launch. The DCE Preamble
> +is not a part of the DRTM trust chain.
> +
> +Dynamic Launch Event
> +--------------------
> +
> +The dynamic launch event is the event, typically a CPU instruction, that
> +triggers the system's dynamic launch mechanism to begin the launch process. The
> +dynamic launch mechanism is also the RoT for the DRTM trust chain.
> +
> +Dynamic Configuration Environment
> +---------------------------------
> +
> +The dynamic launch mechanism may have resulted in a reset of a portion of the
> +system. To bring the system back to an adequate state for system software, the
> +dynamic launch will hand over control to the DCE. Prior to handing over this
> +control, the dynamic launch will measure the DCE. Once the DCE is complete, it
> +will proceed to measure and then execute the Dynamic Launch Measured
> +Environment (DLME).
> +
> +Dynamic Launch Measured Environment
> +-----------------------------------
> +
> +The DLME is the first system kernel to have control of the system, but may not
> +be the last. Depending on the usage and configuration, the DLME may be the
> +final/target operating system, or it may be a bootloader that will load the
> +final/target operating system.
> +
> +Why DRTM?
> +=========
> +
> +A DRTM solution increases the load-time integrity of the system by
> +providing a trust chain that has an immutable hardware RoT and uses a limited
> +number of small, special purpose code to establish the trust chain that starts
> +the target operating system. As mentioned in the Trust Chain section, these are
> +three main factors in driving up the strength of a trust chain. As has been
> +seen with the BootHole exploit (which in fact did not affect the integrity of
> +DRTM solutions), the sophistication of attacks targeting system launch is at an
> +all-time high. There is no reason a system should not employ every available
> +hardware integrity measure. This is the crux of a defense-in-depth
> +approach to system security.
> +
> +In the past, the now closed SMI gap was often pointed to as invalidating DRTM.
> +As has continued to be demonstrated, if/when SMM is corrupted, it can
> +always circumvent all load-time integrity (SRTM and DRTM) because it is a
> +run-time integrity problem. Regardless, Intel and AMD have both deployed
> +runtime integrity for SMI and SMM which is tied directly to DRTM such that this
> +perceived deficiency is now non-existent. The world is moving forward with
> +an expectation that DRTM must be present.
> +
> +Glossary
> +========
> +
> +.. glossary::
> +  integrity
> +    Guarding against improper information modification or destruction, and
> +    includes ensuring information non-repudiation and authenticity.
> +
> +    - NIST Glossary - https://csrc.nist.gov/glossary
> +
> +  mechanism
> +    A process or system that is used to produce a particular result.
> +
> +    - NIST Special Publication 800-160 (VOLUME 1 ) - https://doi.org/10.6028/NIST.SP.800-160v1r1
> +
> +  risk
> +    A measure of the extent to which an entity is threatened by a potential
> +    circumstance or event, and typically a function of: (i) the adverse impacts
> +    that would arise if the circumstance or event occurs; and (ii) the
> +    likelihood of occurrence.
> +
> +    - NIST SP 800-30 Rev. 1 - https://doi.org/10.6028/NIST.SP.800-30r1
> +
> +  security mechanism
> +    A device or function designed to provide one or more security services
> +    usually rated in terms of strength of service and assurance of the design.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
> +
> +  Strength of Mechanism
> +    A scale for measuring the relative strength of a security mechanism
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
> +
> +  transitive trust
> +    Also known as "Inductive Trust", in this process a Root of Trust gives a
> +    trustworthy description of a second group of functions. Based on this
> +    description, an interested entity can determine the trust it is to place in
> +    this second group of functions. If the interested entity determines that
> +    the trust level of the second group of functions is acceptable, the trust
> +    boundary is extended from the Root of Trust to include the second group of
> +    functions. In this case, the process can be iterated. The second group of
> +    functions can give a trustworthy description of the third group of
> +    functions, etc. Transitive trust is used to provide a trustworthy
> +    description of platform characteristics and to prove that non-migratable
> +    keys are in fact non-migratable.
> +
> +    - TCG Glossary - https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-1.0.pdf
> +
> +  trust
> +    The confidence one element has in another that the second element will
> +    behave as expected`
> +
> +    - NISTIR 8320A - https://nvlpubs.nist.gov/nistpubs/ir/2021/NIST.IR.8320A.pdf
> +
> +  trust anchor
> +    An authoritative entity for which trust is assumed.
> +
> +    - NIST SP 800-57 Part 1 Rev. 5 - https://doi.org/10.6028/NIST.SP.800-57pt1r5
> +
> +  trusted
> +    An element that another element relies upon to fulfill critical
> +    requirements on its behalf.
> +
> +    - NISTIR 8320A - https://doi.org/10.6028/NIST.IR.8320A
> +
> +  trusted computing base (TCB)
> +    Totality of protection mechanisms within a computer system, including
> +    hardware, firmware, and software, the combination responsible for enforcing
> +    a security policy.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
> +
> +  trusted computer system
> +    A system that has the necessary security functions and assurance that the
> +    security policy will be enforced and that can process a range of
> +    information sensitivities (i.e. classified, controlled unclassified
> +    information (CUI), or unclassified public information) simultaneously.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
> +
> +  trustworthiness
> +    The attribute of a person or enterprise that provides confidence to others
> +    of the qualifications, capabilities, and reliability of that entity to
> +    perform specific tasks and fulfill assigned responsibilities.
> +
> +    - NIST CNSSI No. 4009 - https://www.cnss.gov/CNSS/issuances/Instructions.cfm
> diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
> new file mode 100644
> index 000000000000..c58fa3a6a607
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch_details.rst
> @@ -0,0 +1,587 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +===================================
> +Secure Launch Config and Interfaces
> +===================================
> +
> +:Author: Daniel P. Smith
> +:Date: March 2025
> +
> +Configuration
> +=============
> +
> +The settings to enable Secure Launch using Kconfig are under::
> +
> +  "Processor type and features" --> "Secure Launch support"
> +
> +A kernel with this option enabled can still be booted using other supported
> +methods.
> +
> +To reduce the Trusted Computing Base (TCB) of the MLE [1]_, the build
> +configuration should be pared down as narrowly as one's use case allows.
> +Fewer drivers (less active hardware) and features reduce the attack surface.
> +As an example in the extreme, the MLE could only have local disk access with no
> +other hardware supports except optional network access for remote attestation.
> +
> +It is also desirable, if possible, to embed the initrd used with the MLE kernel
> +image to reduce complexity.
> +
> +The following are important configuration necessities to always consider:
> +
> +KASLR Configuration
> +-------------------
> +
> +Due to Secure Launch hardware implementation details and how KASLR functions,
> +Secure Launch is not able to interoperate with KASLR currently. Attempts to
> +enable KASLR in a kernel started using Secure Launch may result in crashes and
> +other instabilities at boot. Even in cases where Secure Launch and KASLR work
> +together, it is still recommended that KASLR be disabled to avoid introducing
> +security concerns with unprotected kernel memory.
> +
> +If possible, a kernel being used as an MLE should be built with KASLR disabled::
> +
> +  "Processor type and features" -->
> +      "Build a relocatable kernel" -->
> +          "Randomize the address of the kernel image (KASLR) [ ]"
> +
> +This action unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
> +
> +If it is not possible to disable at build time, then it is recommended to force
> +KASLR to be disabled using the kernel command line when doing a Secure Launch.
> +The kernel parameter is as follows::
> +
> +  nokaslr
> +
> +.. note::
> +    Should KASLR be made capable of reading/using only the protected page
> +    regions set up by the memory protection mechanisms used by the hardware
> +    DRTM capability, it would then become possible to use KASLR with Secure
> +    Launch.
> +
> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
> +MLE completely exposed to DMA after the PMRs [2]_ are disabled. The current
> +default mode is to use IOMMU in lazy translated mode, but strict translated
> +mode, is the preferred IOMMU mode and this should be selected in the build
> +configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU default domain type" -->
> +              "(X) Translated - Strict"
> +
> +In addition, the Intel IOMMU should be on by default. The following sets this as the
> +default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]"
> +
> +and::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
> +              "Enable Intel DMA Remapping Devices by default  [*]"
> +
> +It is recommended that no other command line options should be set to override
> +the defaults above. If there is a desire to run an alternate configuration,
> +then that configuration should be evaluated for what benefits might
> +be gained against the risks for DMA attacks to which the kernel is likely
> +going to be exposed.
> +
> +Secure Launch Resource Table
> +============================
> +
> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
> +for providing information for the pre-launch environment and to pass
> +information to the post-launch environment. The table is populated by one or
> +more bootloaders in the boot chain and used by Secure Launch on how to set up
> +the environment during post-launch. The details for the SLRT are documented
> +in the TrenchBoot Secure Launch Specification [3]_.
> +
> +Intel TXT Interface
> +===================
> +
> +The primary interfaces between the various components in TXT are the TXT MMIO
> +registers and the TXT heap. The MMIO register banks are described in Appendix B
> +of the TXT MLE [1]_ Development Guide.
> +
> +The TXT heap is described in Appendix C of the TXT MLE [1]_ Development
> +Guide. Most of the TXT heap is predefined in the specification. The heap is
> +initialized by firmware and the pre-launch environment and is subsequently used
> +by the SINIT ACM. One section, called the OS to MLE Data Table, is reserved for
> +software to define. This table is set up per the recommendation detailed in
> +Appendix B of the TrenchBoot Secure Launch Specification::
> +
> +        /*
> +         * Secure Launch defined OS/MLE TXT Heap table
> +         */
> +        struct txt_os_mle_data {
> +                u32 version;
> +                u32 reserved;
> +                u64 slrt;
> +                u64 txt_info;
> +                u32 ap_wake_block;
> +                u32 ap_wake_block_size;
> +                u8 mle_scratch[64];
> +        } __packed;
> +
> +Description of structure:
> +
> +=====================  ========================================================================
> +Field                  Use
> +=====================  ========================================================================
> +version                Structure version, current value 1
> +slrt                   Physical address of the Secure Launch Resource Table
> +txt_info               Pointer into the SLRT for easily locating TXT specific table
> +ap_wake_block          Physical address of the block of memory for parking APs after a launch
> +ap_wake_block_size     Size of the AP wake block
> +mle_scratch            Scratch area used post-launch by the MLE kernel. Fields:
> +
> +                        - SL_SCRATCH_AP_EBX area to share %ebx base pointer among CPUs
> +                        - SL_SCRATCH_AP_JMP_OFFSET offset to abs. ljmp fixup location for APs
> +=====================  ========================================================================
> +
> +Error Codes
> +-----------
> +
> +The TXT specification defines the layout for TXT 32 bit error code values.
> +The bit encodings indicate where the error originated (e.g. with the CPU,
> +in the SINIT ACM, in software). The error is written to a sticky TXT
> +register that persists across resets called TXT.ERRORCODE (see the TXT
> +MLE Development Guide). The errors defined by the Secure Launch feature are
> +those generated in the MLE software. They have the format::
> +
> +  0xc0008XXX
> +
> +The low 12 bits are free for defining the following Secure Launch specific
> +error codes.
> +
> +======  ================
> +Name:   SL_ERROR_GENERIC
> +Value:  0xc0008001
> +======  ================
> +
> +Description:
> +
> +Generic catch all error. Currently unused.
> +
> +======  =================
> +Name:   SL_ERROR_TPM_INIT
> +Value:  0xc0008002
> +======  =================
> +
> +Description:
> +
> +The Secure Launch code failed to get access to the TPM hardware interface.
> +This is most likely due to misconfigured hardware or kernel. Ensure the TPM
> +chip is enabled, and the kernel TPM support is built in (it should not be built
> +as a module).
> +
> +======  ==========================
> +Name:   SL_ERROR_TPM_INVALID_LOG20
> +Value:  0xc0008003
> +======  ==========================
> +
> +Description:
> +
> +Either the Secure Launch code failed to find a valid event log descriptor for a
> +version 2.0 TPM, or the event log descriptor is malformed. Usually this
> +indicates incompatible versions of the pre-launch environment and the
> +MLE kernel. The pre-launch environment and the kernel share a structure in the
> +TXT heap and if this structure (the OS-MLE table) is mismatched, this error is
> +common. This TXT heap area is set up by the pre-launch environment, so the
> +issue may originate there. It could also be the sign of an attempted attack.
> +
> +======  ===========================
> +Name:   SL_ERROR_TPM_LOGGING_FAILED
> +Value:  0xc0008004
> +======  ===========================
> +
> +Description:
> +
> +There was a failed attempt to write a TPM event to the event log early in the
> +Secure Launch process. This is likely the result of a malformed TPM event log
> +buffer. Formatting of the event log buffer information is done by the
> +pre-launch environment, so the issue most likely originates there.
> +
> +======  ============================
> +Name:   SL_ERROR_REGION_STRADDLE_4GB
> +Value:  0xc0008005
> +======  ============================
> +
> +Description:
> +
> +During early validation, a buffer or region was found to straddle the 4Gb
> +boundary. Because of the way TXT provides DMA memory protection, this is an unsafe
> +configuration and is flagged as an error. This is most likely a configuration
> +issue in the pre-launch environment. It could also be the sign of an attempted
> +attack.
> +
> +======  ===================
> +Name:   SL_ERROR_TPM_EXTEND
> +Value:  0xc0008006
> +======  ===================
> +
> +Description:
> +
> +There was a failed attempt to extend a TPM PCR in the Secure Launch platform
> +module. This is most likely to due to misconfigured hardware or kernel. Ensure
> +the TPM chip is enabled, and the kernel TPM support is built in (it should not
> +be built as a module).
> +
> +======  ======================
> +Name:   SL_ERROR_MTRR_INV_VCNT
> +Value:  0xc0008007
> +======  ======================
> +
> +Description:
> +
> +During early Secure Launch validation, an invalid variable MTRR count was
> +found. The pre-launch environment passes several MSR values to the MLE to
> +restore including the MTRRs. The values are restored by the Secure Launch early
> +entry point code. After measuring the values supplied by the pre-launch
> +environment, a discrepancy was found, validating the values. It could be the
> +sign of an attempted attack.
> +
> +======  ==========================
> +Name:   SL_ERROR_MTRR_INV_DEF_TYPE
> +Value:  0xc0008008
> +======  ==========================
> +
> +Description:
> +
> +During early Secure Launch validation, an invalid default MTRR type was found.
> +See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +======  ======================
> +Name:   SL_ERROR_MTRR_INV_BASE
> +Value:  0xc0008009
> +======  ======================
> +
> +Description:
> +
> +During early Secure Launch validation, an invalid variable MTRR base value was
> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +======  ======================
> +Name:   SL_ERROR_MTRR_INV_MASK
> +Value:  0xc000800a
> +======  ======================
> +
> +Description:
> +
> +During early Secure Launch validation, an invalid variable MTRR mask value was
> +found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +======  ========================
> +Name:   SL_ERROR_MSR_INV_MISC_EN
> +Value:  0xc000800b
> +======  ========================
> +
> +Description:
> +
> +During early Secure Launch validation, an invalid miscellaneous enable MSR
> +value was found. See SL_ERROR_MTRR_INV_VCNT for more details.
> +
> +======  =========================
> +Name:   SL_ERROR_INV_AP_INTERRUPT
> +Value:  0xc000800c
> +======  =========================
> +
> +Description:
> +
> +The application processors (APs) wait to be woken up by the SMP initialization
> +code. The only interrupt that they expect is an NMI; all other interrupts
> +should be masked. If an AP gets an interrupt other than an NMI, it will
> +cause this error. This error is very unlikely to occur.
> +
> +======  =========================
> +Name:   SL_ERROR_INTEGER_OVERFLOW
> +Value:  0xc000800d
> +======  =========================
> +
> +Description:
> +
> +A buffer base and size passed to the MLE caused an integer overflow when
> +added together. This is most likely a configuration issue in the pre-launch
> +environment. It could also be the sign of an attempted attack.
> +
> +======  ==================
> +Name:   SL_ERROR_HEAP_WALK
> +Value:  0xc000800e
> +======  ==================
> +
> +Description:
> +
> +An error occurred in TXT heap walking code. The underlying issue is a failure to
> +early_memremap() portions of the heap, most likely due to a resource shortage.
> +
> +======  =================
> +Name:   SL_ERROR_HEAP_MAP
> +Value:  0xc000800f
> +======  =================
> +
> +Description:
> +
> +This error is essentially the same as SL_ERROR_HEAP_WALK, but occurred during the
> +actual early_memremap() operation.
> +
> +======  =========================
> +Name:   SL_ERROR_REGION_ABOVE_4GB
> +Value:  0xc0008010
> +======  =========================
> +
> +Description:
> +
> +A memory region used by the MLE is above 4Gb. In general, this is not a problem
> +because memory > 4Gb can be protected from DMA. There are certain buffers that
> +should never be above 4Gb, and one of these caused the violation. This is most
> +likely a configuration issue in the pre-launch environment. It could also be
> +the sign of an attempted attack.
> +
> +======  ==========================
> +Name:   SL_ERROR_HEAP_INVALID_DMAR
> +Value:  0xc0008011
> +======  ==========================
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table, which is expected to be in the
> +TXT heap, could not be found. This is due to a bug in the platform's ACM module
> +or in firmware.
> +
> +======  =======================
> +Name:   SL_ERROR_HEAP_DMAR_SIZE
> +Value:  0xc0008012
> +======  =======================
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table in the TXT heap is too large to be stored
> +for later usage. This error is very unlikely to occur since the area reserved
> +for the copy is far larger than the DMAR should be.
> +
> +======  ======================
> +Name:   SL_ERROR_HEAP_DMAR_MAP
> +Value:  0xc0008013
> +======  ======================
> +
> +Description:
> +
> +The backup copy of the ACPI DMAR table in the TXT heap could not be mapped. The
> +underlying issue is a failure to early_memremap() the DMAR table, most likely
> +due to a resource shortage.
> +
> +======  ====================
> +Name:   SL_ERROR_HI_PMR_BASE
> +Value:  0xc0008014
> +======  ====================
> +
> +Description:
> +
> +On a system with more than 4Gb of RAM, the high PMR [2]_ base address should be
> +set to 4Gb. This error is due to that not being the case. This PMR value is set
> +by the pre-launch environment, so the issue most likely originates there. It
> +could also be the sign of an attempted attack.
> +
> +======  ====================
> +Name:   SL_ERROR_HI_PMR_SIZE
> +Value:  0xc0008015
> +======  ====================
> +
> +Description:
> +
> +On a system with more than 4Gb of RAM, the high PMR [2]_ size should be set to
> +cover all RAM > 4Gb. This error is due to that not being the case. This PMR
> +value is set by the pre-launch environment, so the issue most likely originates
> +there. It could also be the sign of an attempted attack.
> +
> +======  ====================
> +Name:   SL_ERROR_LO_PMR_BASE
> +Value:  0xc0008016
> +======  ====================
> +
> +Description:
> +
> +The low PMR [2]_ base should always be set to address zero. This error is due
> +to that not being the case. This PMR value is set by the pre-launch environment
> +so the issue most likely originates there. It could also be the sign of an
> +attempted attack.
> +
> +======  ====================
> +Name:   SL_ERROR_LO_PMR_MLE
> +Value:  0xc0008017
> +======  ====================
> +
> +Description:
> +
> +This error indicates the MLE image is not covered by the low PMR [2]_ range.
> +The PMR values are set by the pre-launch environment, so the issue most likely
> +originates there. It could also be the sign of an attempted attack.
> +
> +======  =======================
> +Name:   SL_ERROR_INITRD_TOO_BIG
> +Value:  0xc0008018
> +======  =======================
> +
> +Description:
> +
> +The external initrd provided is larger than 4Gb. This is not a valid
> +configuration for Secure Launch due to managing DMA protection.
> +
> +======  =========================
> +Name:   SL_ERROR_HEAP_ZERO_OFFSET
> +Value:  0xc0008019
> +======  =========================
> +
> +Description:
> +
> +During a TXT heap walk, an invalid/zero next table offset value was found. This
> +indicates the TXT heap is malformed. The TXT heap is initialized by the
> +pre-launch environment, so the issue most likely originates there. It could
> +also be a sign of an attempted attack. In addition, ACM is also responsible for
> +manipulating parts of the TXT heap, so the issue could be due to a bug in the
> +platform's ACM module.
> +
> +======  =============================
> +Name:   SL_ERROR_WAKE_BLOCK_TOO_SMALL
> +Value:  0xc000801a
> +======  =============================
> +
> +Description:
> +
> +The AP wake block buffer passed to the MLE via the OS-MLE TXT heap table is not
> +large enough. This value is set by the pre-launch environment, so the issue
> +most likely originates there. It also could be the sign of an attempted attack.
> +
> +======  ===========================
> +Name:   SL_ERROR_MLE_BUFFER_OVERLAP
> +Value:  0xc000801b
> +======  ===========================
> +
> +Description:
> +
> +One of the buffers passed to the MLE via the OS-MLE TXT heap table overlaps
> +with the MLE image in memory. This value is set by the pre-launch environment
> +so the issue most likely originates there. It could also be the sign of an
> +attempted attack.
> +
> +======  ==========================
> +Name:   SL_ERROR_BUFFER_BEYOND_PMR
> +Value:  0xc000801c
> +======  ==========================
> +
> +Description:
> +
> +One of the buffers passed to the MLE via the OS-MLE TXT heap table is not
> +protected by a PMR. This value is set by the pre-launch environment, so the
> +issue most likely originates there. It could also be the sign of an attempted
> +attack.
> +
> +======  =============================
> +Name:   SL_ERROR_OS_SINIT_BAD_VERSION
> +Value:  0xc000801d
> +======  =============================
> +
> +Description:
> +
> +The version of the OS-SINIT TXT heap table is bad. It must be 6 or greater.
> +This value is set by the pre-launch environment, so the issue most likely
> +originates there. It could also be the sign of an attempted attack. It is also
> +possible though very unlikely that the platform is so old that the ACM being
> +used requires an unsupported version.
> +
> +======  =====================
> +Name:   SL_ERROR_EVENTLOG_MAP
> +Value:  0xc000801e
> +======  =====================
> +
> +Description:
> +
> +An error occurred in the Secure Launch module while mapping the TPM event log.
> +The underlying issue is memremap() failure, most likely due to a resource
> +shortage.
> +
> +======  ========================
> +Name:   SL_ERROR_TPM_INVALID_ALGS
> +Value:  0xc000801f
> +======  ========================
> +
> +Description:
> +
> +The TPM 2.0 event log reports either no hashing algorithms, invalid algorithm ID
> +or an algorithm size larger than the max size recognized by the TPM support code.
> +
> +======  ===========================
> +Name:   SL_ERROR_TPM_EVENT_COUNT
> +Value:  0xc0008020
> +======  ===========================
> +
> +Description:
> +
> +The TPM 2.0 event log contains an event with a digest count that is not equal
> +to the algorithm count of the overall log. This is an invalid configuration
> +that could indicate either a bug or a possible attack.
> +
> +======  ==========================
> +Name:   SL_ERROR_TPM_INVALID_EVENT
> +Value:  0xc0008021
> +======  ==========================
> +
> +Description:
> +
> +An invalid/malformed event was found in the TPM event log while reading it.
> +Since only trusted entities are supposed to be writing the event log, this
> +would indicate either a bug or a possible attack.
> +
> +======  =====================
> +Name:   SL_ERROR_INVALID_SLRT
> +Value:  0xc0008022
> +======  =====================
> +
> +Description:
> +
> +The Secure Launch Resource Table is invalid or malformed and is unusable. This
> +implies the pre-launch code did not properly set up the SLRT.
> +
> +======  ===========================
> +Name:   SL_ERROR_SLRT_MISSING_ENTRY
> +Value:  0xc0008023
> +======  ===========================
> +
> +Description:
> +
> +The Secure Launch Resource Table is missing a required entry within it. This
> +implies the pre-launch code did not properly set up the SLRT.
> +
> +======  =================
> +Name:   SL_ERROR_SLRT_MAP
> +Value:  0xc0008024
> +======  =================
> +
> +Description:
> +
> +An error occurred in the Secure Launch module while mapping the Secure Launch
> +Resource table. The underlying issue is memremap() failure, most likely due to
> +a resource shortage.
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measured and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    PMR: Intel VTd has a feature in the IOMMU called Protected Memory Registers.
> +    There are two of these registers and they allow all DMA to be blocked
> +    to large areas of memory. The low PMR can cover all memory below 4Gb on 2Mb
> +    boundaries. The high PMR can cover all RAM on the system, again on 2Mb
> +    boundaries. This feature is used during a Secure Launch by TXT.
> +
> +.. [3]
> +    Secure Launch Specification: https://trenchboot.org/specifications/Secure_Launch/
> diff --git a/Documentation/security/launch-integrity/secure_launch_overview.rst b/Documentation/security/launch-integrity/secure_launch_overview.rst
> new file mode 100644
> index 000000000000..492f2b12e297
> --- /dev/null
> +++ b/Documentation/security/launch-integrity/secure_launch_overview.rst
> @@ -0,0 +1,240 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (c) 2019-2025 Daniel P. Smith <dpsmith@apertussolutions.com>
> +
> +======================
> +Secure Launch Overview
> +======================
> +
> +:Author: Daniel P. Smith
> +:Date: March 2025
> +
> +Overview
> +========
> +
> +The TrenchBoot project started the development of the Secure Launch kernel feature
> +to provide a more generalized approach. The focus of the effort is twofold: first,
> +to make the Linux kernel directly aware of the launch protocol used by platforms
> +such as Intel, AMD/Hygon, Arm, and potentially OpenPOWER; second, to make the
> +Linux kernel able to initiate a dynamic launch. It is through this approach that
> +the Secure Launch kernel feature creates a basis for the Linux kernel to be used
> +in a variety of dynamic launch use cases.
> +
> +.. note::
> +    A quick note on terminology. The larger open source project itself is
> +    called TrenchBoot, which is hosted on GitHub (links below). The kernel
> +    feature enabling the use of the x86 technology is referred to as "Secure
> +    Launch" within the kernel code.
> +
> +Goals
> +=====
> +
> +The first use case that the TrenchBoot project focused on was the ability for
> +the Linux kernel to be started by a dynamic launch as part of an early
> +launch sequence. In this case, the dynamic launch will be initiated by
> +any bootloader with associated support added to it. The first targeted bootloader
> +in this case was GRUB2. An integral part of establishing a measurement-based
> +launch integrity involves measuring everything that is intended to be executed
> +(kernel image, initrd, etc.) and everything that will configure that kernel to
> +execute (command line, boot params, etc.), then storing those measurements in a
> +protected manner. Both the Intel and AMD dynamic launch implementations leverage
> +the Trusted Platform Module (TPM) to store those measurements. The TPM itself
> +has been designed such that a dynamic launch unlocks a specific set of Platform
> +Configuration Registers (PCR) for holding measurement taken during the dynamic
> +launch. These are referred to as the DRTM PCRs, PCRs 17-22. Further details on this
> +process can be found respectively in the documentation for the GETSEC instruction
> +provided by Intel's TXT and the SKINIT instruction provided by AMD's AMD-V. The
> +documentation on these technologies can be readily found online; see
> +the `Resources`_ section below for references.
> +
> +.. note::
> +    Currently, only Intel TXT is supported in this first release of the Secure
> +    Launch feature. AMD/Hygon SKINIT and Arm support will be added in a
> +    subsequent release.
> +
> +To enable the kernel to be launched by GETSEC, the Secure Launch stub
> +must be built into the setup section of the compressed kernel to handle the
> +specific state that the dynamic launch process leaves the BSP. Also, the Secure
> +Launch stub must measure everything that is going to be used as early as
> +possible. This stub code and subsequent code must also deal with the specific
> +state that the dynamic launch leaves the APs in.
> +
> +Design Decisions
> +================
> +
> +Several design decisions were made during the development of the Secure
> +Launch feature. The two primary guiding decisions were:
> +
> + - Keeping the Secure Launch code as separate from the rest of the kernel
> +   as possible.
> + - Modifying the existing boot path of the kernel as little as possible.
> +
> +The following illustrate how the implementation followed these design
> +decisions:
> +
> + - All the entry point code necessary to properly configure the system post
> +   launch is found in st_stub.S in the compressed kernel image. This code
> +   validates the state of the system, restores necessary system operating
> +   configurations and properly handles post launch CPU states.
> + - After the sl_stub.S is complete, it jumps directly to the unmodified
> +   startup_32 kernel entry point.
> + - A single call is made to a function sl_main() prior to the main kernel
> +   decompression step. This code performs further validation and takes the
> +   needed DRTM measurements.
> + - After the call to sl_main(), the main kernel is decompressed and boots as
> +   it normally would.
> + - Support is introduced in the SMP boot code to properly wake the APs. This
> +   is required due to the unique state the dynamic launch leaves the APs in
> +   (i.e. they cannot be woken with the standard INIT-SIPI sequence).
> + - Final setup for the Secure Launch kernel is done in a separate Secure
> +   Launch module that is loaded via a late initcall. This code is responsible
> +   for extending the measurements taken earlier into the TPM DRTM PCRs and
> +   setting up the securityfs interface to allow access to the TPM event log and
> +   public TXT registers.
> + - On the reboot and kexec paths, calls are made to a function to finalize the
> +   state of the Secure Launch kernel.
> +
> +A final note is that the original concept was to extend the DRTM PCRs in the
> +Secure Launch stub when the measurements were taken. This requires access to the
> +TPM early during boot time. Since the mainline kernel TPM driver relies heavily
> +on kernel interfaces not available in the compressed kernel, it was not possible
> +to reuse the mainline TPM driver. An alternate solution that has been implemented,
> +moves the extension operations to the Secure Launch module in the mainline
> +kernel, where the TPM driver would be available.
> +
> +Basic Boot Flow
> +===============
> +
> +Outlined here is a summary of the boot flow for Secure Launch. A more detailed
> +review of the Secure Launch process can be found in the Secure Launch
> +Specification (a link is in the `Resources`_ section).
> +
> +Pre-launch: *Phase where the environment is prepared and configured to initiate
> +the secure launch by the boot chain.*
> +
> + - The SLRT is initialized, and dl_stub is placed in memory.
> + - Load the kernel, initrd and ACM [2]_ into memory.
> + - Set up the TXT heap and page tables describing the MLE [1]_ per the
> +   specification.
> + - If non-UEFI platform, dl_stub is called.
> + - If UEFI platform, SLRT registered with UEFI and efi-stub called.
> + - Upon completion, efi-stub will call EBS followed by dl_stub.
> + - The dl_stub will prepare the CPU and the TPM for the launch.
> + - The secure launch is then initiated with the GETSET[SENTER] instruction.
> +
> +Post-launch: *Phase where control is passed from the ACM to the MLE and the secure
> +kernel begins execution.*
> +
> + - Entry from the dynamic launch jumps to the SL stub.
> + - SL stub fixes up the world on the BSP.
> + - For TXT, SL stub wakes the APs, fixes up their worlds.
> + - For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.
> + - SL stub jumps to startup_32.
> + - SL main does validation of buffers and memory locations. It sets
> +   the boot parameter loadflag value SLAUNCH_FLAG to inform the main
> +   kernel that a Secure Launch was done.
> + - SL main locates the TPM event log and writes the measurements of
> +   configuration and module information into it.
> + - Kernel boot proceeds normally from this point.
> + - During early setup, slaunch_setup() runs to finish validation
> +   and setup tasks.
> + - The SMP bring up code is modified to wake the waiting APs via the monitor
> +   address.
> + - APs jump to rmpiggy and start up normally from that point.
> + - SL platform module is registered as a late initcall module. It reads
> +   the TPM event log and extends the measurements taken into the TPM PCRs.
> + - SL platform module initializes the securityfs interface to allow
> +   access to the TPM event log and TXT public registers.
> + - Kernel boot finishes booting normally.
> + - SEXIT support to leave SMX mode is present on the kexec path and
> +   the various reboot paths (poweroff, reset, halt).
> +
> +PCR Usage
> +=========
> +
> +In the TCG DRTM architecture there are three PCRs defined for usage: PCR.Details
> +(PCR17), PCR.Authorities (PCR18), and PCR.DLME_Authority (PCR19). For a deeper
> +understanding of Details and Authorities, review the TCG DRTM architecture
> +documentation.
> +
> +To determine PCR usage, Linux Secure Launch follows the TrenchBoot Secure
> +Launch Specification of using a measurement policy stored in the Secure Launch
> +Resource Table (SLRT), which is defined in the Secure Launch Specification.
> +This policy details what should be measured and the PCR in which to store the
> +measurement. The measurement policy provides the ability to select the
> +PCR.DLME_Detail (PCR20) PCR as the location for the DRTM components measured by
> +the kernel, e.g. external initrd image. This can be combined with storing
> +the user authority in the PCR.DLME_Authority PCR to seal/attest to different
> +variations of platform details/authorities and user details/authorities. An
> +example of how this can be achieved was presented in the FOSDEM - 2021 talk
> +"Secure Upgrades with DRTM".
> +
> +SHA-1 Usage
> +-----------
> +
> +Secure Launch is written to be compliant with the Intel TXT Measured Launch
> +Developer's Guide. The MLE Guide dictates that the system can be configured to
> +use both the SHA-1 and SHA-2 hashing algorithms. The choice is dictated by the
> +hash algorithm banks firmware enabled at system start time.
> +
> +Regardless of the preference towards SHA-2, if the firmware elected to start
> +with the SHA-1 and SHA-2 banks active and the dynamic launch was configured to
> +include SHA-1, Secure Launch is obligated to record measurements for all
> +algorithms requested in the launch configuration. If SHA-1 can be disabled in
> +the firmware setup, then TXT and Secure Launch will only use the SHA-2 banks
> +while establishing the launch environment.
> +
> +Ultimately, the security of an RTM solution relies on how and what measurements are
> +used to assess the health of a system. If SHA-1 measurements are made but not
> +used, i.e. the attestation enforcement only uses SHA-2, then it has no impact
> +on the security of the system.
> +
> +Finally, there are older systems with TPM 1.2 chips that only support SHA-1. If
> +the system integrator (whether that be the OEM, employer, distro maintainer,
> +system administrator, or end user) chooses to use older hardware that only has
> +a TPM 1.2 chip, then they accept the risk it creates in their solution.
> +
> +Resources
> +=========
> +
> +The TrenchBoot project:
> +
> +https://trenchboot.org
> +
> +Secure Launch Specification:
> +
> +https://trenchboot.org/specifications/Secure_Launch/
> +
> +Trusted Computing Group's D-RTM Architecture:
> +
> +https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture_v1-0_Published_06172013.pdf
> +
> +TXT documentation in the Intel TXT MLE Development Guide:
> +
> +https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
> +
> +TXT instructions documentation in the Intel SDM Instruction Set volume:
> +
> +https://software.intel.com/en-us/articles/intel-sdm
> +
> +AMD SKINIT documentation in the System Programming manual:
> +
> +https://www.amd.com/system/files/TechDocs/24593.pdf
> +
> +GRUB Secure Launch support:
> +
> +https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub
> +
> +FOSDEM 2021: Secure Upgrades with DRTM
> +
> +https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
> +
> +.. [1]
> +    MLE: Measured Launch Environment is the binary runtime that is measured and
> +    then run by the TXT SINIT ACM. The TXT MLE Development Guide describes the
> +    requirements for the MLE in detail.
> +
> +.. [2]
> +    ACM: Intel's Authenticated Code Module. This is the 32b bit binary blob that
> +    is run securely by the GETSEC[SENTER] during a measured launch. It is described
> +    in the Intel documentation on TXT and versions for various chipsets are
> +    signed and distributed by Intel.

